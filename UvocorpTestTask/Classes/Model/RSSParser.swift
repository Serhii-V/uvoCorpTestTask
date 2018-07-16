//
//  RSSParser.swift
//  UvocorpTestTask
//
//  Created by Serhii on 7/12/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import Alamofire
import AlamofireRSSParser

enum NetworkResponseStatus {
    case success
    case error(string: String)
}

class RSSParser {
    public static func getRSSFeedResponse(path: String, complitionHandler: @escaping ( _ response: RSSFeed?, _ status: NetworkResponseStatus) -> Void) {
        Alamofire.request(path).responseRSS { response in
            if let rssFeedXML = response.result.value {
                complitionHandler(rssFeedXML, .success)
            } else {
                complitionHandler(nil, .error(string: response.result.error?.localizedDescription ?? "error" ))
            }
        }
    }
}
