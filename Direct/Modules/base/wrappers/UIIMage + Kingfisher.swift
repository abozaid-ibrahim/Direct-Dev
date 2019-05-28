//
//  UIIMage + Kingfisher.swift
//  Direct
//
//  Created by abuzeid on 5/27/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import Kingfisher
extension UIImageView{
    func setImage(url:String){
        guard let urlObj = URL(string:url) else {
            return
        }
        self.kf.setImage(with: urlObj)
    }
}
