//
//  AboutUsTableCell.swift
//  Direct
//
//  Created by abuzeid on 5/15/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class AboutUsTableCell: UITableViewCell, TableCell {
    static var cellId: String = "AboutUsTableCell"

    func setCellData(_: String) {}

    typealias CellDataModel = String

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
