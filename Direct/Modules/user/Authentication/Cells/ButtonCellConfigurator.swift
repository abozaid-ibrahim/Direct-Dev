//
//  ButtonCellConfigurator.swift
//  Daleel
//
//  Created by abdelrahman mohamed on 5/2/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import UIKit

struct ButtonCellConfigurator {
    var title: String?
    var backgroundColor: UIColor
    var titleColor: UIColor?
    var borderWidth: CGFloat
    var borderColor: UIColor
    var type: AuthCellType

    init(title: String?, color: UIColor?, background: UIColor, type: AuthCellType) {
        self.title = title
        self.titleColor = color
        self.backgroundColor = .clear
        self.borderWidth = 0
        self.borderColor = .black
        self.type = type
    }

    init(title: String?, color: UIColor?, background: UIColor, border width: CGFloat, borderColor: UIColor, type: AuthCellType) {
        self.title = title
        self.titleColor = color
        self.backgroundColor = .clear
        self.borderWidth = width
        self.borderColor = borderColor
        self.type = type
    }
}
