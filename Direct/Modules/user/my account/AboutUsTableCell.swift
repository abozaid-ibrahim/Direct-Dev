//
//  AboutUsTableCell.swift
//  Direct
//
//  Created by abuzeid on 5/15/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class AboutUsTableCell: UITableViewCell {
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var cellTitleLabel: UILabel!
    @IBOutlet var extensionImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor  = .appVeryLightGray
        selectionStyle = .none
    }
}
