//
//  HelpTableCell.swift
//  Direct
//
//  Created by abuzeid on 5/20/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class HelpTableCell: UITableViewCell, TableCell {
    static var cellId: String = "HelpTableCell"
    @IBOutlet private var titleLbl: UILabel!

    func setCellData(_ model: CellDataModel) {
        titleLbl.text = model.category
    }

    typealias CellDataModel = FAQPage

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
