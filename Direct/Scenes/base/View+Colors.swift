//
//  View+Colors.swift
//  Direct
//
//  Created by abuzeid on 5/15/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import UIKit
extension UIView{
    func setGradient(colors:UIColor...){
        let gl = CAGradientLayer()
        gl.colors = colors
        gl.locations = [0.0, 1.0]
        layer.addSublayer(gl)
    }
}
