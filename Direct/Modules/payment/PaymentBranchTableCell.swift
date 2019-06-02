//
//  PaymentBranchTableCell.swift
//  Direct
//
//  Created by abuzeid on 4/30/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class PaymentBranchTableCell: UITableViewCell, TableCell {
    static var cellId: String = "PaymentBranchTableCell"

    func setCellData(_ model: CellDataModel) {
        titleLbl.text = model.paymentName
        descLbl.text = model.paymentMethodDescription.html2String
        
    }

    typealias CellDataModel = ChildPaymentMethod

    @IBOutlet var containerLayout: UIView!

    @IBOutlet private var descLbl: UILabel!
    @IBOutlet private var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        selectCell(false)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectCell(selected)
    }

    private func selectCell(_ selected: Bool) {
        containerLayout.borderWidthV = 1
        if selected {
            containerLayout.borderColorV = UIColor.appPumpkinOrange
            containerLayout.backgroundColor = UIColor.tangerine7
        } else {
            containerLayout.borderColorV = UIColor.lightGray
            containerLayout.backgroundColor = UIColor.white
        }
    }
}

