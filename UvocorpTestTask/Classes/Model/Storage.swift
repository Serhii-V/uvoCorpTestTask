//
//  Storage.swift
//  UvocorpTestTask
//
//  Created by Serhii on 7/12/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import Foundation

class Storage {
    static let `default` = Storage()
    private let newsKey = "savedNews"

    private init() {}

    static func addNewsToStorage(news: String) {
       UserDefaults.standard.set(news, forKey: "savedNews")
    }

    static func getNews() -> Any? {
            return UserDefaults.standard.object(forKey: "savedNews")
    }

    static func isNewsPresent() -> Bool {
        return UserDefaults.standard.object(forKey: "savedNews") == nil
    }
}
