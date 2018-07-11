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
    @IBOutlet weak var recentlyReaded: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runTimer()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !Storage.isNewsPresent() {
            guard let title = Storage.getNews() as? String else { return }
                recentlyReaded.text =  title
        }
    }

    func runTimer() {
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateDate), userInfo: nil, repeats: true)
    }

    @objc func updateDate() {
        let newDate = DateFormatter.localizedString(from: Date(), dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.medium)
        dateLabel.text = newDate
    }



}
