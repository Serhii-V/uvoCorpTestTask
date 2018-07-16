//
//  News.swift
//  UvocorpTestTask
//
//  Created by Serhii on 7/15/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import Foundation

extension News: Equatable {
    static func == (lhs: News, rhs: News) -> Bool {
        if lhs.title == rhs.title, lhs.typeOfNews == rhs.typeOfNews {
            return true
        }
        return false
    }
}
