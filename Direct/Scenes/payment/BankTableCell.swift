//
//  BankTableCell.swift
//  Direct
//
//  Created by abuzeid on 5/1/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class BankTableCell: UITableViewCell ,TableCell{
    static var cellId: String = "BankTableCell"
    
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
