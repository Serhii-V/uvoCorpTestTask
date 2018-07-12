//
//  NewsVC.swift
//  UvocorpTestTask
//
//  Created by Serhii on 7/12/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import UIKit

class NewsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!


    let arr = ["123", "321", "14241", "23@", "23234234", "234242342423", "123", "321", "14241", "23@", "23234234", "234242342423"]
    let links = ["123", "321", "14241", "23@", "23234234", "234242342423", "123", "321", "14241", "23@", "23234234", "234242342423"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = arr[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "newsDetail", sender: nil)
        Storage.addNewsTitle(news: arr[indexPath.row])
        Storage.addNewsTitle(news: links[indexPath.row])
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.black
    }


    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
}
