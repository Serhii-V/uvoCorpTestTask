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
    var currentNews: Results<NewsRLM>?

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
            UpdateManager.updateBuisnessNews()
            currentNews = realm.objects(NewsRLM.self).sorted(byKeyPath: "pubDate", ascending: false)
        } else {
            print("other news")
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

        if segmentedControl.selectedSegmentIndex == 0 {
            cell.textLabel?.text = news[indexPath.row].title
            cell.detailTextLabel?.text = news[indexPath.row].itemDescription
        } else {
            cell.textLabel?.text = "Other news"
            cell.detailTextLabel?.text = "Other news details"
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "newsDetail", sender: nil)
        guard let news = currentNews else { return }
        guard let title = news[indexPath.row].title, let link = news[indexPath.row].link  else { return }
        Storage.addNewsTitle(news: title )
        Storage.addNewsLink(news: link)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.black
    }


    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
}
