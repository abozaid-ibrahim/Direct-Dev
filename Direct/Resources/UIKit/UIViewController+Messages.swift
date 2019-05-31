//
//  UIViewController+Messages.swift
//  Direct
//
//  Created by Abdoelrhman Eaita on 5/31/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//


import UIKit
import SwiftMessages

extension UIViewController {
    
    func showError(title: String? = "general_error_title".localized, sub: String?, type: Theme = .warning, layout: MessageView.Layout = .statusLine) {
        // Instantiate a message view from the provided card view layout. SwiftMessages searches for nib
        // files in the main bundle first, so you can easily copy them into your project and make changes.
        let view = MessageView.viewFromNib(layout: layout)
        
        // Theme message elements with the warning style.
        view.configureTheme(type)
        view.button?.isHidden = true
        // Add a drop shadow.
        //        view.configureDropShadow()
        
        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
        
        view.configureContent(title: title ?? "general_error_title".localized, body: sub ?? "", iconText: "")
        
        // Show the message.
        SwiftMessages.show(view: view)
    }
}
