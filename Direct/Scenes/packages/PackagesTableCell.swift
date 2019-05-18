//
//  PackagesTableCell.swift
//  Direct
//
//  Created by abuzeid on 5/10/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class PackagesTableCell: UITableViewCell, TableCell {
    static var cellId: String = "PackagesTableCell"

    func setCellData(_: String) {}

    typealias CellDataModel = String

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
