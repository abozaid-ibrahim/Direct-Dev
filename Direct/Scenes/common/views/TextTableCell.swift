//
//  TextTableCell.swift
//  Direct
//
//  Created by abuzeid on 5/11/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class TextTableCell: UITableViewCell  ,TableCell{
    typealias CellDataModel = String
    static var cellId: String = "TextTableCell"
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
