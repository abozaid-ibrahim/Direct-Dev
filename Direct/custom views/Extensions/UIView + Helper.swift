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
        print(type)
        return instantiateViewController(withIdentifier: "\(type)")
    }
}
