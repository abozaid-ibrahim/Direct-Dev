//
//  OrderTableCell.swift
//  Direct
//
//  Created by abuzeid on 5/10/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class OrderTableCell: UITableViewCell, TableCell {
    static var cellId: String = "OrderTableCell"
    @IBOutlet private var titleLbl: UILabel!
    @IBOutlet private var descLbl: UILabel!
    @IBOutlet private var pendingDocsLbl: UILabel!

    typealias CellDataModel = CompletedVisa

    func setCellData(_ model: CellDataModel) {
        titleLbl.text = model.trackNo
        descLbl.text = model.visaStatusLog?.first?.visaStatus
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        titleLbl.font = .appBoldFontWith(size: 20)
        descLbl.font = .appRegularFontWith(size: 12)
        pendingDocsLbl.font = .appBoldFontWith(size: 14)

    }
}
