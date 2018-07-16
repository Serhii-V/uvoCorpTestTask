//
//  Date+string.swift
//  UvocorpTestTask
//
//  Created by Serhii on 7/15/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import Foundation

extension Date {
    func getCurrentDate() -> String {
        let formater = DateFormatter()
        formater.dateStyle = .medium
        formater.timeStyle = .medium
        return formater.string(from: self)
    }
}
