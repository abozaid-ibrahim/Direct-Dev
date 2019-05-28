//
//  SingleRowTableCell.swift
//  Direct
//
//  Created by abuzeid on 4/29/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class SingleRowTableCell: UITableViewCell, TableCell {
    static var cellId: String = "SingleRowTableCell"

    func setCellData(_ model: String) {
        txtLbl.text = model
    }

    typealias CellDataModel = String

    @IBOutlet private var txtLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
