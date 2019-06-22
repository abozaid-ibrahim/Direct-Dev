//
//  UIView.swift
//  Direct
//
//  Created by abuzeid on 6/14/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

extension UITextField {
    func neverShowKeypad() {
        inputView = UIView()
    }
}



extension UIStoryboard {
    func controller(_ type: UIViewController.Type) -> UIViewController {
        return instantiateViewController(withIdentifier: "\(type)")
    }
}

extension UIView {
    @discardableResult // 1
    func fromNib() -> UIView? { // 2
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView else { // 3
            // xib not loaded, or its top view is of the wrong type
            return nil
        }
        addSubview(contentView) // 4
        contentView.translatesAutoresizingMaskIntoConstraints = false // 5
        contentView.sameBoundsTo(parentView: self)
        return contentView // 7
    }

    static func loadNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
