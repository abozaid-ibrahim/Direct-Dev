//
//  ReqDescTableCell.swift
//  Direct
//
//  Created by abuzeid on 6/8/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class ReqDescTableCell: UITableViewCell, TableCell {
    static let cellId = "ReqDescTableCell"
    typealias CellDataModel = String
    @IBOutlet private var txtLbl: UILabel!
    func setCellData(_ model: String) {
        txtLbl.text = model
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
