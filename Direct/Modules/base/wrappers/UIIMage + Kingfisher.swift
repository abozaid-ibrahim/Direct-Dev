//
//  UIIMage + Kingfisher.swift
//  Direct
//
//  Created by abuzeid on 5/27/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Kingfisher
import UIKit
extension UIImageView {
    func setImage(url: String) {
        guard let urlObj = URL(string: url) else {
            return
        }
        kf.setImage(with: urlObj)
    }
}
