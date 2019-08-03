//
//  View+Colors.swift
//  Direct
//
//  Created by abuzeid on 5/15/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    func setGradient(colors: UIColor...) {
        let gl = CAGradientLayer()
        gl.colors = colors
        gl.startPoint = CGPoint(x: 0, y: 1)
        gl.endPoint = CGPoint(x: 1, y: 1)

        gl.frame = bounds
        layer.insertSublayer(gl, at:    0)
        
    }
}
