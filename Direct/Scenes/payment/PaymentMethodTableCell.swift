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

    typealias CellDataModel = (String, [UIImage?])

    @IBOutlet private var cardImageViews: [UIImageView]!

    @IBOutlet private var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCellData(_ model: (String, [UIImage?])) {
        titleLbl.text = model.0
        for (index, img) in model.1.enumerated() {
            cardImageViews[index].image = img
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        containerLayout.borderColorV = UIColor.appMango
        containerLayout.backgroundColor = UIColor.appMango
    }
}
