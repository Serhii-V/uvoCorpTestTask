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

    // timer for updateing clock label every seconds
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
        let newDate = DateFormatter.localizedString(from: Date(), dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.medium)
        let strArr = newDate.components(separatedBy: "at ")
        timeLabel.text = strArr[1]
        timeLabel.makeOutLine(oulineColor: .darkGray, foregroundColor: .lightGray)
        //change date only once per day
        if strArr[1] == "00:00:01" || dateLabel.text == "Date" {
            updateDate(str: strArr[0])
        }
    }

    // change date
    func updateDate(str: String) {
       dateLabel.text = str
    }
}
