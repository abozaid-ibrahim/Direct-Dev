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
                if font.fontName.range(of: "-Bd") == nil {
                    font = UIFont(name: newValue, size: font.pointSize)
                }

            } else {
                font = UIFont(name: newValue, size: 14)
            }
        }
    }

    var substituteFontNameBold: String {
        get { return font.fontName }
        set {
             if font.fontName.range(of: "-Bd") != nil {
                font = UIFont(name: newValue, size: font.pointSize)
            }
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
