//
//  UILabel+Animation.swift
//  UvocorpTestTask
//
//  Created by Serhii on 7/15/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import UIKit

extension UILabel {
    func animate(inputText: String, charDelay: TimeInterval) {
        DispatchQueue.main.async {
            self.text = " "

            for (index, character) in inputText.enumerated() {
                DispatchQueue.main.asyncAfter(deadline: .now() + charDelay * Double(index)) {
                    self.text?.append(character)
                }
            }
        }
    }
}


