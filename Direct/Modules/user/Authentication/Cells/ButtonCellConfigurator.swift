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

    init(title: String?, color: UIColor?, background _: UIColor, type: AuthCellType) {
        self.title = title
        titleColor = color
        backgroundColor = .clear
        borderWidth = 0
        borderColor = .black
        self.type = type
    }

    init(title: String?, color: UIColor?, background _: UIColor, border width: CGFloat, borderColor: UIColor, type: AuthCellType) {
        self.title = title
        titleColor = color
        backgroundColor = .clear
        borderWidth = width
        self.borderColor = borderColor
        self.type = type
    }
}
