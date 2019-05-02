//
//  UIViewController+Helpers.swift
//  Direct
//
//  Created by abuzeid on 5/2/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
extension UIViewController{
    static func instance(_ mainStoryboardId:String)->UIViewController{
        return UIStoryboard.main.instantiateViewController(withIdentifier: mainStoryboardId)
    }
}
extension UIStoryboard{
    static var main:UIStoryboard{
        return UIStoryboard(name: "Main", bundle: nil)
    }
}
