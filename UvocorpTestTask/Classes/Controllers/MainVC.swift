//
//  MainVC.swift
//  UvocorpTestTask
//
//  Created by Serhii on 7/12/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var recentlyReaded: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateTime()
        runTimer()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameLabel.animate(inputText: "Serhii", charDelay: 0.3)
        checkForNewsTitle()
    }

    // Timer that updates clock label every second
    func runTimer() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }

    // show title of news if it present
    func checkForNewsTitle() {
        if !Storage.isNewsTitlePresent() {
            guard let title = Storage.getNewsTitle() as? String else { return }
            recentlyReaded.text =  title
        }
    }

    // get current time and show it
    @objc func updateTime() {
        let dateString = Date().getCurrentDate()
        let strArr = dateString.components(separatedBy: "at ")
        timeLabel.text = strArr[1]
        timeLabel.makeOutLine(oulineColor: .darkGray, foregroundColor: .lightGray)
        if strArr[1] == "00:00:01" || dateLabel.text == "Date" {
            updateDate(str: strArr[0])
        }
    }

    func updateDate(str: String) {
       dateLabel.text = str
    }
}
