//
//  UISegment +APP.swift
//  Direct
//
//  Created by abuzeid on 6/7/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import UIKit
extension UISegmentedControl {
    func appFont() {
        let font = UIFont.appRegularFontWith(size: 13)
        setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
    }
}

extension Optional where Wrapped == String {
    var isValidText: Bool {
        if let value = self {
            return !value.isEmpty
        }
        return false
    }
}
