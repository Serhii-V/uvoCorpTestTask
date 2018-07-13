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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runTimer()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkForNewsTitle()
    }

    func runTimer() {
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }

    func checkForNewsTitle() {
        if !Storage.isNewsTitlePresent() {
            guard let title = Storage.getNewsTitle() as? String else { return }
            recentlyReaded.text =  title
        }
    }

    @objc func updateTime() {
        let newDate = DateFormatter.localizedString(from: Date(), dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.medium)
        let strArr = newDate.components(separatedBy: "at ")
        timeLabel.text = strArr[1]
        if strArr[1] == "00:00:01" || dateLabel.text == "Date" {
            updateDate(str: strArr[0])
        }
    }

    func updateDate(str: String) {
        dateLabel.text = str
    }
}
