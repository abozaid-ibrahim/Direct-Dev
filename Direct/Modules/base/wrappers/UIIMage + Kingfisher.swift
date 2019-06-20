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
    func setImage(_ nameOrPath: String) {
        guard let urlObj = URL(string: nameOrPath) else {
            if let img = UIImage(named: nameOrPath) {
                self.image = img
            }
            return
        }
        kf.setImage(with: urlObj)
    }
}
