//
//  NewsRLM.swift
//  UvocorpTestTask
//
//  Created by Serhii on 7/13/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import Foundation
import RealmSwift

enum Type: String {
    case business
    case entertainment
    case environment
}


class NewsRLM: Object {
    @objc dynamic var title: String?
    @objc dynamic var itemDescription: String?
    @objc dynamic var link: String?
    @objc dynamic var pubDate: Date?
    @objc dynamic var typeOfNews: String = ""

    override static func primaryKey() -> String {
        return "title"
    }

    convenience init(_ value: News) {
        self.init()
        guard let type = value.typeOfNews  else { return }

        self.title = value.title
        self.itemDescription = value.itemDescription
        self.link = value.link
        self.pubDate = value.pubDate
        self.typeOfNews = type
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
                let news = News(title: title, itemDescription: newsRlm.itemDescription, link: newsRlm.link, pubDate: newsRlm.pubDate, type: newsRlm.typeOfNews)
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

    class func removeNewsBy(_ type: Type) {
        do {
            let realm = try Realm()
            let allObjectsByType = realm.objects(NewsRLM.self).filter("typeOfNews == %@", type.rawValue)
            try! realm.write {
                realm.delete(allObjectsByType)
                print("Objects by type removed")
            }
        } catch {
            print("can`t remove objects by type")
        }
    }

    class func getArrayOfNewsBy(type: Type) -> [News] {
        var array = [News]()
        do {
            let realm = try Realm()
            print(type.rawValue)
            let arrayRLM = realm.objects(NewsRLM.self).filter("typeOfNews == %@", type.rawValue).sorted(byKeyPath: "pubDate", ascending: false)
            for item in arrayRLM {
                guard let news = News.newsRLMToNews(newsRLM: item) else { continue }
                array.append(news)
            }
        } catch {
            print("can`t get realm data")
        }
        return array
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


