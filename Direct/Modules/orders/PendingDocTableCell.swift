//
//  PendingDocTableCell.swift
//  Direct
//
//  Created by abuzeid on 7/7/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class PendingDocTableCell: UITableViewCell, TableCell {
    static var cellId: String = "PendingDocTableCell"
    
    func setCellData(_ model: CellDataModel) {
        textLbl.text = model
    }
    
    typealias CellDataModel = String
    
    @IBOutlet private var textLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
