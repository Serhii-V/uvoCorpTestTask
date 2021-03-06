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

    static func getNews(type: Type, completion: @escaping ()->()) {
        var link: String

        switch type {
        case .business:
            link = "http://feeds.reuters.com/reuters/businessNews"
        case .entertainment:
            link = "http://feeds.reuters.com/reuters/entertainment"
        case .environment:
            link = "http://feeds.reuters.com/reuters/environment"
        }

        RSSParser.getRSSFeedResponse(path: link) { (result, status) in
            guard let result = result else { return }
            guard let firstTitle = result.items[0].title else { return }
            if NewsRLM.getNewsByKey(by: firstTitle) == nil {
                NewsRLM.removeNewsBy(type)
                for item in result.items {
                    guard let itemTitle = item.title else { return }
                    let description = UpdateManager.seperateItemDescription(str: item.itemDescription)
                    let news = News(title: itemTitle, itemDescription: description, link: item.link, pubDate: item.pubDate, type: type.rawValue)
                    NewsRLM.createInRealm(news)
                }
            }
            completion()
        }
    }

    static func seperateItemDescription(str: String?) -> String? {
        guard let str = str else { return nil }
        let strArray = str.components(separatedBy: "<div")

        return strArray[0]
    }
}
