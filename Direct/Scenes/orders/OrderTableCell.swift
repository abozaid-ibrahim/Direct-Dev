//
//  OrderTableCell.swift
//  Direct
//
//  Created by abuzeid on 5/10/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class OrderTableCell: UITableViewCell ,TableCell{
    static var cellId: String = "OrderTableCell"
    
    func setCellData(_ model: String) {
        
    }
    
    typealias CellDataModel = String
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
