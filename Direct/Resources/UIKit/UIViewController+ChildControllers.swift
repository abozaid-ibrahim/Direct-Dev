//
//  UIViewController+ChildControllers.swift
//  Pazar
//
//  Created by abdelrahman mohamed on 3/1/18.
//  Copyright © 2018 Semicolon. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)
        if let frame = frame { child.view.frame = frame }
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func add(_ child: UIViewController, container: UIView) {
        addChild(child)
        container.addSubview(child.view)
        child.view.frame = container.frame
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}
