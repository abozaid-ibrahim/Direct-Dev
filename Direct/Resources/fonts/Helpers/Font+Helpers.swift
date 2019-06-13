//
//  Font+Helpers.swift
//  Direct
//
//  Created by Abdoelrhman Eaita on 5/31/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

extension UIFont {
    static func getLocalizedFont(type: FontTypesWithSize) -> UIFont {
        switch type {
        case let .bold(value):
            return CairoFont.bold.font(for: value)
        case let .regular(value):
            return CairoFont.regular.font(for: value)
        case let .semiBold(value):
            return CairoFont.semiBold.font(for: value)
        case let .light(value):
            return CairoFont.light.font(for: value)
        default:
            return UIFont.systemFont(ofSize: 17)
        }
    }
}

enum CairoFont: String, AppFont {
    case black = "Cairo-Black"
    case bold = "Cairo-Bold"
    case light = "Cairo-Light"
    case extraLight = "Cairo-ExtraLight"
    case regular = "Cairo-Regular"
    case semiBold = "Cairo-SemiBold"
}

protocol AppFont {
    func descriptor(for size: CGFloat) -> UIFontDescriptor
    func font(for size: CGFloat) -> UIFont
}

extension AppFont where Self: RawRepresentable {
    func descriptor(for size: CGFloat) -> UIFontDescriptor {
        return UIFontDescriptor(name: rawValue as! String, size: size.responsive)
    }

    func font(for size: CGFloat) -> UIFont {
        return UIFont(descriptor: descriptor(for: size), size: size.responsive)
    }
}

extension CGFloat {
    var responsive: CGFloat {
        var deltaSize: CGFloat = 0
        switch UIDevice.deviceType {
        case .iPhone4_4s,
             .iPhone5_5s:
            deltaSize = -1
        case .iPhone6_6s:
            deltaSize = 2
        case .iPhone6p_6ps:
            deltaSize = 2
        default:
            deltaSize = 0
        }

        return self + deltaSize
    }
}

extension UIDevice {
    enum DeviceTypes {
        case iPhone4_4s
        case iPhone5_5s
        case iPhone6_6s
        case iPhone6p_6ps
        case after_iPhone6p_6ps
    }

    static var deviceType: DeviceTypes {
        switch UIScreen.main.bounds.height {
        case 480.0:
            return .iPhone4_4s
        case 568.0:
            return .iPhone5_5s
        case 667.0:
            return .iPhone6_6s
        case 736.0:
            return .iPhone6p_6ps
        default:
            return .after_iPhone6p_6ps
        }
    }
}

enum FontTypesWithSize {
    case regular(CGFloat), bold(CGFloat), italic(CGFloat), semiBold(CGFloat), light(CGFloat)
}
