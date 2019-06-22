//
//  UIImage+ Resizing.swift
//  Direct
//
//  Created by abuzeid on 6/21/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import SwifterSwift

extension UIImage{
    func apiSize()->UIImage?{
        return self.scaled(toHeight: 1000,opaque: false)?.compressed(quality: 0.5)
    }
}
