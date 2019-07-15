//
//  BankTableCell.swift
//  Direct
//
//  Created by abuzeid on 5/1/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class BankTableCell: UITableViewCell, TableCell {
    static var cellId: String = "BankTableCell"

    @IBOutlet private var txtLbl: UILabel!
    @IBOutlet private var logoIV: UIImageView!
    func setCellData(_ model: CellDataModel) {
        txtLbl.text = model.paymentMethodDescription.html2String
        logoIV.setImage(with: model.logo ?? "")
    }

    typealias CellDataModel = ChildPaymentMethod

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none

        backgroundColor = .appVeryLightGray
    }
}
