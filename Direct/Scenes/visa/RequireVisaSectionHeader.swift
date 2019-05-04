//
//  RequireVisaSectionHeader.swift
//  Direct
//
//  Created by abuzeid on 4/28/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class RequireVisaSectionHeader: UIView {
    @IBOutlet private var iconView: UIImageView!

    @IBOutlet private var textLbl: UILabel!
    func setData(text: String, img: UIImage) {
        iconView.image = img
        textLbl.text = text
    }
}
