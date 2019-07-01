//
//  UIFont+UIView.swift
//  Direct
//
//  Created by abuzeid on 5/15/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import UIKit

struct AppFonts {
    static let regularFont = "Cairo-Regular"
    static let boldFont = "Cairo-Bold"
}

extension UIFont {
    class func appRegularFontWith(size: CGFloat) -> UIFont {
        return UIFont(name: AppFonts.regularFont, size: size)!
    }

    class func appBoldFontWith(size: CGFloat) -> UIFont {
        return UIFont(name: AppFonts.boldFont, size: size)!
    }
}

extension UILabel {
    var substituteFontName: String {
        get { return font.fontName }
        set {
            if font != nil {
                let fontNameToTest = self.font.fontName.lowercased()
                var fontName = newValue
                if fontNameToTest.range(of: "bold") != nil {
                    fontName = AppFonts.boldFont
                } else if fontNameToTest.range(of: "medium") != nil {
                    fontName = AppFonts.regularFont
                } else if fontNameToTest.range(of: "light") != nil {
                    fontName = AppFonts.regularFont
                } else if fontNameToTest.range(of: "ultralight") != nil {
                    fontName = AppFonts.regularFont
                } else {
                    fontName = AppFonts.regularFont
                }
                self.font = UIFont(name: fontName, size: self.font.pointSize)

            } else {
                font = UIFont(name: newValue, size: 14)
            }
        }
    }

    var substituteFontNameBold: String {
        get { return font.fontName }
        set {
            let fontNameToTest = self.font.fontName.lowercased()
            var fontName = newValue
            if fontNameToTest.range(of: "bold") != nil {
                fontName = newValue
            } else if fontNameToTest.range(of: "medium") != nil {
                fontName = newValue
            } else if fontNameToTest.range(of: "light") != nil {
                fontName = newValue
            } else if fontNameToTest.range(of: "ultralight") != nil {
                fontName = newValue
            }
            self.font = UIFont(name: fontName, size: self.font.pointSize)
        }
    }
}

extension UITextField {
    var substituteFontName: String {
        get { return font!.fontName }
        set {
            font = UIFont(name: newValue, size: (font?.pointSize) ?? 13)
        }
    }
}
