//
//  NewsRLM.swift
//  UvocorpTestTask
//
//  Created by Serhii on 7/13/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import Foundation
import RealmSwift


class NewsRLM: Object {
    @objc dynamic var title: String?
    @objc dynamic var itemDescription: String?
    @objc dynamic var link: String?
    @objc dynamic var pubDate: Date?

    override static func primaryKey() -> String {
        return "title"
    }

    convenience init(_ value: News) {
        self.init()

        self.title = value.title
        self.itemDescription = value.itemDescription
        self.link = value.link
        self.pubDate = value.pubDate
    }

    class func createInRealm(_ news: News) {
        do {
            let realm = try Realm()
            let newsRLM = NewsRLM(news)
            realm.beginWrite()
            realm.add(newsRLM)
            try realm.commitWrite()
        } catch {
            print("can`t create realm News object")
        }
    }

    class func getNews() -> [News]? {
        let news: [News]?
        do {
            let realm = try Realm()
            let results = realm.objects(NewsRLM.self)

            var buffer = [News]()
            for newsRlm in results {
                guard let title = newsRlm.title else { continue }
                let news = News(title: title, itemDescription: newsRlm.itemDescription, link: newsRlm.link, pubDate: newsRlm.pubDate)
                buffer.append(news)
            }
            news = buffer
        } catch {
            news = nil
        }
        return news
    }

    class func getNews(by title: String) -> NewsRLM? {
        let condition = NSPredicate(format: "identifier == %@", title)
        let newsRLM: NewsRLM?

        do {
            let realm = try Realm()
            let results = realm.objects(NewsRLM.self).filter(condition)
            newsRLM = results.first
        } catch {
            newsRLM = nil
        }
        return newsRLM
    }

    class func getNewsByKey(by key: String) -> NewsRLM? {
        let newsRLM: NewsRLM?

        do {
            let realm = try Realm()
            newsRLM = realm.object(ofType: NewsRLM.self, forPrimaryKey: key)
        } catch {
            newsRLM = nil
        }
        return newsRLM
    }

    class func removeAllObjects() {
        do {
            let realm = try Realm()
            let allUploadingNews = realm.objects(NewsRLM.self)
            try! realm.write {
                realm.delete(allUploadingNews)
            }
        } catch {
            print("can`t remove all objects")
        }
    }
}
