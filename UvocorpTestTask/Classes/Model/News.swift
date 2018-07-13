//
//  News.swift
//  UvocorpTestTask
//
//  Created by Serhii on 7/13/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import Foundation

class News {
    var title: String
    var itemDescription: String?
    var link: String?
    var pubDate: Date?

    init(title: String, itemDescription: String?, link: String?, pubDate: Date? ) {
        self.title = title
        self.itemDescription = itemDescription
        self.link = link
        self.pubDate = pubDate
    }
}
