//
//  News.swift
//  UvocorpTestTask
//
//  Created by Serhii on 7/13/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import Foundation

class News: Equatable {

    var title: String
    var itemDescription: String?
    var link: String?
    var pubDate: Date?
    var typeOfNews: String?

    init(title: String, itemDescription: String?, link: String?, pubDate: Date?, type: String?) {
        self.title = title
        self.itemDescription = itemDescription
        self.link = link
        self.pubDate = pubDate
        self.typeOfNews = type
    }

    class func newsRLMToNews(newsRLM: NewsRLM) -> News? {
        guard let title = newsRLM.title else { return nil}
        return News(title: title, itemDescription: newsRLM.itemDescription, link: newsRLM.link, pubDate: newsRLM.pubDate, type: newsRLM.typeOfNews)
    }

    static func == (lhs: News, rhs: News) -> Bool {
        if lhs.title == rhs.title, lhs.typeOfNews == rhs.typeOfNews {
            return true
        }
        return false
    }
}
