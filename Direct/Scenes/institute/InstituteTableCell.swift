//
//  InstituteTableCell.swift
//  Direct
//
//  Created by abuzeid on 5/2/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class InstituteTableCell: UITableViewCell ,TableCell{
    typealias CellDataModel = String
    static var cellId: String = "InstituteTableCell"
    func setCellData(_ model: String) {
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
