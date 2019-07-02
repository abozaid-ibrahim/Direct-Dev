//
//  Progress.swift
//  Direct
//
//  Created by abuzeid on 5/15/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import NVActivityIndicatorView
import UIKit
protocol Loader {
    static func show()
    static func hide()
}

final class Progress: Loader {
    private static let activityData = ActivityData(size: nil, message: nil, messageFont: nil, messageSpacing: nil, type: .ballRotate, color: UIColor.appMango, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: 3, backgroundColor: nil, textColor: nil)

    static func show() {
        print("loader>> start")

        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }

    static func hide() {
        print("loader>> end")
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}
