//
//  HomeCollectionSectionHeader.swift
//  Direct
//
//  Created by abuzeid on 4/26/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class HomeCollectionSectionHeader: UICollectionReusableView {
    static let id = "HomeCollectionSectionHeader"
    @IBOutlet var textLbl: UILabel!
    @IBOutlet var iconView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
