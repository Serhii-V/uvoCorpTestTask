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

    private var currentNews: [News]?
    private var timer: Timer?
    private var selectedNews: News?
    private var spinner = Spinner()
    private let group = DispatchGroup()
    private var entertaimentArray: [News] = []
    private var enviromentArray: [News] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateData()
        startTimer()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopTimer()
    }

    // MARK: - get data methods
    @objc func updateData() {
        spinner.start()
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
            self.spinner.stop()
        }
    }

    func updateOtherNews() {
        getEntertaimentNews()
        getEnviromentNews()
        group.notify(queue: .main) {
            self.currentNews = self.entertaimentArray + self.enviromentArray
            self.tableView.reloadData()
            self.spinner.stop()
        }
    }

    func getEntertaimentNews() {
        group.enter()
        UpdateManager.getNews(type: .entertainment) {
            self.self.entertaimentArray = NewsRLM.getArrayOfNewsBy(type: .entertainment)
            self.group.leave()
        }
    }

    func getEnviromentNews() {
        group.enter()
        UpdateManager.getNews(type: .environment) {
            self.enviromentArray = NewsRLM.getArrayOfNewsBy(type: .environment)
            self.group.leave()
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
        guard let news = currentNews else { return }
        selectedNews = news[indexPath.row]
        Storage.addNewsTitle(news: news[indexPath.row].title)
        performSegue(withIdentifier: "newsDetail", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newsDetail" {
            if let nextVC = segue.destination as? FullNewsVC {
                nextVC.news = selectedNews
            }
        }
    }

    // MARK: - timer methods
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

    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        updateData()
    }
}
