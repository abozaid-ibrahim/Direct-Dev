//
//  PaymentMethodTableCell.swift
//  Direct
//
//  Created by abuzeid on 4/30/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class PaymentMethodTableCell: UITableViewCell, TableCell {
    @IBOutlet private var containerLayout: UIView!
    static var cellId: String = "PaymentMethodTableCell"

    typealias CellDataModel = PaymentMethod

    @IBOutlet private var cardImageViews: [UIImageView]!

    @IBOutlet private var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        selectStyle(selected: false)
    }

    func setCellData(_ model: CellDataModel) {
        titleLbl.text = model.paymentName
        for iv in cardImageViews {
            iv.isHidden = true
        }
        cardImageViews.first?.isHidden = false
        cardImageViews.first?.setImage(with: model.imageName ?? "")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectStyle(selected: selected)
    }

    func selectStyle(selected: Bool) {
        if selected {
            containerLayout.borderColorV = UIColor.appPumpkinOrange
            containerLayout.backgroundColor = UIColor.tangerine7

        } else {
            containerLayout.borderColorV = UIColor.lightGray
            containerLayout.backgroundColor = UIColor.white
        }
    }
}
