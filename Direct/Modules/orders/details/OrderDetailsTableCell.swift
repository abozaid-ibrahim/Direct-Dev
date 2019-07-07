//
//  OrderDetailsTableCell.swift
//  Direct
//
//  Created by abuzeid on 7/7/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class OrderDetailsTableCell: UITableViewCell, TableCell {
        static var cellId: String = "OrderDetailsTableCell"
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
            backgroundColor = .appVeryLightGray
        }
}
