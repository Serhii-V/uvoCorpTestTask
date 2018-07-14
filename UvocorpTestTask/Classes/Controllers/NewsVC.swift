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

    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
    }

    func prepare() {
        tableView.delegate = self
        tableView.dataSource = self
        runTimer()
    }

    func runTimer() {
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateData), userInfo: nil, repeats: true)
    }

    @objc func updateData() {
        if segmentedControl.selectedSegmentIndex == 0 {
            UpdateManager.updateNews(type: .business)
            currentNews = NewsRLM.getArrayOfNewsBy(type: .business)
        } else {
            UpdateManager.updateNews(type: .entertainment)
            UpdateManager.updateNews(type: .environment)
            let entertaimentArray = NewsRLM.getArrayOfNewsBy(type: .entertainment)
            let enviromentArray = NewsRLM.getArrayOfNewsBy(type: .environment)
            currentNews = entertaimentArray + enviromentArray
        }
        tableView.reloadData()
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
        tableView.reloadData()
    }
}
