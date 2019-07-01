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
    @objc var substituteFontName: String {
        get { return font.fontName }
        set {
            if let fnt = self.font {
                print("xxr>\(self.font.fontName.lowercased())")
                if self.font.fontName.lowercased().range(of: "bold") == nil {
                    print("xxx>r")
                    self.font = UIFont(name: AppFonts.regularFont, size: fnt.pointSize)
                } else {
                    print("xxx>b")

                    self.font = UIFont(name: AppFonts.boldFont, size: self.font.pointSize)
                }
            } else {
                self.font = UIFont(name: newValue, size: 14)
            }
        }
    }

//    @objc var substituteFontNameBold: String {
//        get { return font.fontName }
//        set {
//            print("xxb>\(self.font.fontName.lowercased())")
//            if self.font.fontName.lowercased().range(of: "bold") != nil {
//                self.font = UIFont(name: newValue, size: self.font.pointSize)
//            }
//        }
//    }
}

extension UITextField {
    @objc var substituteFontName: String {
        get { return font!.fontName }
        set {
            font = UIFont(name: newValue, size: (font?.pointSize) ?? 13)
        }
    }
}
