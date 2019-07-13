//
//  BranchesTableCell.swift
//  Direct
//
//  Created by abuzeid on 7/13/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class BranchesTableCell: UITableViewCell, TableCell {
    static var cellId: String = "BranchesTableCell"
    @IBOutlet private var txtLbl: UILabel!
    func setCellData(_ model: String) {
        txtLbl.text = model
    }

    typealias CellDataModel = String

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
