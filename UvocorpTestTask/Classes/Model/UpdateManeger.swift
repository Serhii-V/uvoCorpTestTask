//
//  UpdateManeger.swift
//  UvocorpTestTask
//
//  Created by Serhii on 7/13/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import Foundation
import RealmSwift

class UpdateManager {
    public static func updateBuisnessNews() {
        let buisnessNewsLink = "http://feeds.reuters.com/reuters/businessNews"

        RSSParser.getRSSFeedResponse(path: buisnessNewsLink) { (result, status) in
            guard let result = result else { return }
            guard let firstTitle = result.items[0].title else { return }
            if NewsRLM.getNewsByKey(by: firstTitle) == nil {
                NewsRLM.removeAllObjects()
                for item in result.items {
                    guard let itemTitle = item.title else { return }
                    let description = UpdateManager.seperateItemDescription(str: item.itemDescription)
                    let news = News(title: itemTitle, itemDescription: description, link: item.link, pubDate: item.pubDate)
                    NewsRLM.createInRealm(news)
                }
            }

        }
    }

    public static func updateOtherNews() {
        let entertaimantNewsLink = "http://feeds.reuters.com/reuters/entertainment"
        let enviromentNewsLink = "http://feeds.reuters.com/reuters/environment"

    }

    public static func seperateItemDescription(str: String?) -> String? {
        guard let str = str else { return nil }

        let strArray = str.components(separatedBy: "<div")

        return strArray[0]
    }

    func getFullNewsByLink(link: String) {

    }
}
