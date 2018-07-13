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

    static func addNewsTitle(news: String) {
       UserDefaults.standard.set(news, forKey: "newsTitle")
    }

    static func addNewsLink(news: String) {
        UserDefaults.standard.set(news, forKey: "newsLink")
    }

    static func addNewsnewsDescription(news: String) {
        UserDefaults.standard.set(news, forKey: "newsDescription")
    }

    static func getNewsTitle() -> Any? {
            return UserDefaults.standard.object(forKey: "newsTitle")
    }

    static func getNewsLink() -> Any? {
        return UserDefaults.standard.object(forKey: "newsLink")
    }

    static func getNewsDescription() -> Any? {
        return UserDefaults.standard.object(forKey: "newsDescription")
    }

    static func isNewsTitlePresent() -> Bool {
        return UserDefaults.standard.object(forKey: "newsTitle") == nil
    }

    static func isNewsLinkPresent() -> Bool {
        return UserDefaults.standard.object(forKey: "newsLink") == nil
    }

    static func isNewsDescriptionPresent() -> Bool {
        return UserDefaults.standard.object(forKey: "newsDescription") == nil
    }


}
