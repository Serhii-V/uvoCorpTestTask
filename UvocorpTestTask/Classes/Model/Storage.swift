//
//  Storage.swift
//  UvocorpTestTask
//
//  Created by Serhii on 7/12/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import Foundation

class Storage {
    static func addNewsTitle(news: String) {
       UserDefaults.standard.set(news, forKey: "newsTitle")
    }

    static func getNewsTitle() -> Any? {
        return UserDefaults.standard.object(forKey: "newsTitle")
    }

    static func isNewsTitlePresent() -> Bool {
        return UserDefaults.standard.object(forKey: "newsTitle") == nil
    }
}
