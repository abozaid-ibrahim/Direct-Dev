//
//  FloatingTextField.swift
//  Direct
//
//  Created by abuzeid on 5/7/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class FloatingTextField:  SkyFloatingLabelTextField {
    
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
