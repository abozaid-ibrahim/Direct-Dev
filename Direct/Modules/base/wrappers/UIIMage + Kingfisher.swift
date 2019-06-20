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
    func setImage(with value: String, suffix: String? = nil, placeholder: UIImage? = nil, selected: Bool = false) {
        if let localImage = UIImage(named: value) {
            image = localImage
        } else if let url = URL(string: value) {
            kf.setImage(with: url)
        } else {
            image = nil
        }
    }

    func addCircle(color: UIColor, border: CGFloat) {
        self.layer.cornerRadius = (self.bounds.size.width / 2)
        self.layer.borderWidth = border
        self.layer.borderColor = color.cgColor
        self.layer.masksToBounds = true
    }
}
