//
//  UIView +Any.swift
//  Direct
//
//  Created by abuzeid on 6/24/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import M13Checkbox

extension M13Checkbox {
    func applyAppCheckBoxStyle() {
        boxType = .square
        checkState = .unchecked
        hideBox = false
        secondaryCheckmarkTintColor = UIColor.appPumpkinOrange
        secondaryTintColor = UIColor.gray
        markType = .checkmark
        boxLineWidth = 1.5
        checkmarkLineWidth = 1.5
        stateChangeAnimation = .fill
    }
}
