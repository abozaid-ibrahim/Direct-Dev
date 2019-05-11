//
//  InstituteDetailsTableCell.swift
//  Direct
//
//  Created by abuzeid on 5/11/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import M13Checkbox

class InstituteDetailsTableCell: UITableViewCell ,TableCell{
    typealias CellDataModel = String
    @IBOutlet weak var radioBox: M13Checkbox!
    static var cellId: String = "InstituteDetailsTableCell"
    func setCellData(_ model: String) {
    
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
radioBox.checkState = .checked
//        radioBox.isEnabled = false
    }

    @IBAction func checkBox(_ sender: M13Checkbox) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
