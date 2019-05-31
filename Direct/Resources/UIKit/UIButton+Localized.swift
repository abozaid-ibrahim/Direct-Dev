//
//  UIButton+Localized.swift
//  Direct
//
//  Created by Abdoelrhman Eaita on 5/31/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

@IBDesignable
extension UIButton {
    
    @IBInspectable var localizedText: String? {
        get {
            return currentTitle
        }
        set {
            setTitle(newValue?.localized, for: .normal)
        }
    }
    
    var localizedFont: FontTypesWithSize {
        set {
            titleLabel?.font = UIFont.getLocalizedFont(type: newValue)
        }get {
            return .regular(16)
        }
    }
    
}

