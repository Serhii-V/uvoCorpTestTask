//
//  NewsVC.swift
//  UvocorpTestTask
//
//  Created by Serhii on 7/12/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import UIKit
import RealmSwift


class NewsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    let realm = try! Realm()
    var currentNews: [News]?
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
    }

    func prepare() {
        tableView.delegate = self
        tableView.dataSource = self
        updateData()
    }

    func startTimer () {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateData), userInfo: nil, repeats: true)
        }
    }

    func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startTimer()
        print("viewWillAppear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopTimer()
        print("didDisapear")
    }

    @objc func updateData() {
         LoaderController.sharedInstance.showLoader()
        if segmentedControl.selectedSegmentIndex == 0 {
            updateBuisnessNews()
        } else {
            updateOtherNews()
        }
    }

    func updateBuisnessNews() {
        UpdateManager.getNews(type: .business) {
            self.currentNews = NewsRLM.getArrayOfNewsBy(type: .business)
            self.tableView.reloadData()
            LoaderController.sharedInstance.removeLoader()
        }
    }

//    func updateOtherNews() {
//        LoaderController.sharedInstance.showLoader()
//        UpdateManager.updateNews(type: .entertainment)
//        UpdateManager.updateNews(type: .environment)
//        let entertaimentArray = NewsRLM.getArrayOfNewsBy(type: .entertainment)
//        let enviromentArray = NewsRLM.getArrayOfNewsBy(type: .environment)
//        currentNews = entertaimentArray + enviromentArray
//        tableView.reloadData()
//        LoaderController.sharedInstance.removeLoader()
//    }

    func updateOtherNews() {
        LoaderController.sharedInstance.showLoader()
        let group = DispatchGroup()
        DispatchQueue.global().async(group: group, execute: {
             UpdateManager.updateNews(type: .entertainment)
        })

        DispatchQueue.global().async(group: group, execute: {
            UpdateManager.updateNews(type: .environment)
        })

        group.notify(queue: DispatchQueue.main) {
            let entertaimentArray = NewsRLM.getArrayOfNewsBy(type: .entertainment)
            let enviromentArray = NewsRLM.getArrayOfNewsBy(type: .environment)
            self.currentNews = entertaimentArray + enviromentArray
            self.tableView.reloadData()
            LoaderController.sharedInstance.removeLoader()
        }
    }


    // MARK: - setup tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let news = currentNews else { return 0 }
        return news.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        guard let news = currentNews else { return cell }

        cell.textLabel?.text = news[indexPath.row].title

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "newsDetail", sender: nil)
        guard let news = currentNews else { return }
        guard let description = news[indexPath.row].itemDescription  else { return }
        Storage.addNewsTitle(news: news[indexPath.row].title )
        Storage.addNewsnewsDescription(news: description)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.black
    }


    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        updateData()
        tableView.reloadData()
    }
}
