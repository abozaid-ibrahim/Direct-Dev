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
    @IBOutlet private var dateLbl: UILabel!
    @IBOutlet private var statusView: UIImageView!

    func setCellData(_ model: CellDataModel) {
        titleLbl.text = model.visaStatusLog?.first?.message
        dateLbl.text = model.visaStatusLog?.first?.visaStatus
    }

    typealias CellDataModel = CompletedVisa

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
