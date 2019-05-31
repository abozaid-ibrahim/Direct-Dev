//
//  TextLabelConfigurator.swift
//  Daleel
//
//  Created by abdelrahman mohamed on 5/22/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import UIKit

struct TextLabelConfigurator {
    var text: String?
    var attributedText: NSAttributedString?
    var font: UIFont?
    var textColor: UIColor?
    var type: AuthCellType
    var textAlign: NSTextAlignment?

    init(attributedText: NSAttributedString, type: AuthCellType) {
        self.attributedText = attributedText
        self.type = type
    }

    init(text: String?, font: UIFont?, textColor: UIColor?, textAlign: NSTextAlignment, type: AuthCellType) {
        self.text = text
        self.font = font
        self.textColor = textColor
        self.type = type
        self.textAlign = textAlign
    }
}
