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

    func setCellData(_ model: (String, String)) {
        titleLbl.text = model.0
        descLbl.text = model.1
    }

    typealias CellDataModel = (String, String)

    @IBOutlet var containerLayout: UIView!

    @IBOutlet private var descLbl: UILabel!
    @IBOutlet private var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        containerLayout.borderColorV = UIColor.appMango
        containerLayout.backgroundColor = UIColor.appMango }
}
