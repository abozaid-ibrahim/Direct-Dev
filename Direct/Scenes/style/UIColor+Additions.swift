//
//  UIColor+Additions.swift
//  Direct - iOS App
//
//  Generated on Zeplin. (4/24/2019).
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

import UIKit

extension UIColor {
    @nonobjc class var appPumpkinOrange: UIColor {
        return UIColor(red: 252.0 / 255.0, green: 128.0 / 255.0, blue: 4.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var appMango: UIColor {
        return UIColor(red: 1.0, green: 159.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var appVeryLightPink: UIColor {
        return UIColor(white: 243.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var appOffWhite: UIColor {
        return UIColor(white: 249.0 / 255.0, alpha: 1.0)
    }
}

final class GradientColors {
    static var gl: CAGradientLayer {
        let colorTop = UIColor(red: 192.0 / 255.0, green: 38.0 / 255.0, blue: 42.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 35.0 / 255.0, green: 2.0 / 255.0, blue: 2.0 / 255.0, alpha: 1.0).cgColor

        let gl = CAGradientLayer()
        gl.colors = [colorTop, colorBottom]
        gl.locations = [0.0, 1.0]
        return gl
    }
}

extension UIView {
    func setGradient(_ gradient: CAGradientLayer) {
        layer.addSublayer(gradient)
    }
}
