//
//  InstituteDetailsTableCell.swift
//  Direct
//
//  Created by abuzeid on 5/11/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import M13Checkbox
import SwifterSwift
import UIKit

class InstituteDetailsTableCell: UITableViewCell, TableCell {
    typealias CellDataModel = String
    @IBOutlet var radioBox: M13Checkbox!
    static var cellId: String = "InstituteDetailsTableCell"
    func setCellData(_ model: String) {
//        mostWantedLbl.text = ""
    }
    
    @IBOutlet var mostWantedLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        radioBox.checkState = .checked
        
    }
    
    @IBAction func checkBox(_ sender: M13Checkbox) {}
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
