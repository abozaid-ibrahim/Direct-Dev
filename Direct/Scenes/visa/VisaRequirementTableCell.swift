//
//  VisaRequirementTableCell.swift
//  Direct
//
//  Created by abuzeid on 4/28/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class VisaRequirementTableCell: UITableViewCell {
    @IBOutlet var textlbl: UILabel!
    static let cellId = "VisaRequirementTableCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
