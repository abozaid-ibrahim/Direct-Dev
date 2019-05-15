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
    static let boldFont = "Cairo-Regular"
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
        get { return self.font.fontName }
        set {
            if self.font != nil{
            if self.font.fontName.range(of: "-Bd") == nil {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
                }
                
            }else{
                self.font = UIFont(name: newValue, size: 14)

            }
        }
    }

    var substituteFontNameBold: String {
        get { return self.font.fontName }
        set {
            if self.font.fontName.range(of: "-Bd") != nil {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
    }
}

extension UITextField {
    var substituteFontName: String {
        get { return self.font!.fontName }
        set {
            self.font = UIFont(name: newValue, size: (self.font?.pointSize) ?? 13)
        }
    }
}

