//
//  HelpTableCell.swift
//  Direct
//
//  Created by abuzeid on 5/20/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class HelpTableCell: UITableViewCell,TableCell {
    static var cellId: String = "HelpTableCell"
    
    func setCellData(_ model: String) {
        
    }
    
    typealias CellDataModel = String
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
