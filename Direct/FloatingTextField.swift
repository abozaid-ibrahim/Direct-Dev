//
//  FloatingTextField.swift
//  Direct
//
//  Created by abuzeid on 5/7/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import SkyFloatingLabelTextField
import UIKit

class FloatingTextField: SkyFloatingLabelTextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        CommonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        CommonInit()
    }

    func CommonInit() {
        selectedLineColor = .lightGray
        selectedTitleColor = .lightGray
        cornerRadiusV = 8
        borderWidthV = 1
        borderColorV = UIColor.lightGray
        backgroundColor = .white
    }

    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
