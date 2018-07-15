//
//  UILabel+OutlineText.swift
//  UvocorpTestTask
//
//  Created by Serhii on 7/15/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import UIKit

extension UILabel{

    func makeOutLine(oulineColor: UIColor, foregroundColor: UIColor) {
        let strokeTextAttributes = [
        NSAttributedStringKey.strokeColor : oulineColor,
        NSAttributedStringKey.foregroundColor : foregroundColor,
        NSAttributedStringKey.strokeWidth : -4.0,
        NSAttributedStringKey.font : self.font
        ] as [NSAttributedStringKey : Any]
        self.attributedText = NSMutableAttributedString(string: self.text ?? "", attributes: strokeTextAttributes)
    }
}
