//
//  VisaRequirementTableCell.swift
//  Direct
//
//  Created by abuzeid on 4/28/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class VisaRequirementTableCell: UITableViewCell, TableCell {
    func setCellData(_ model: Requirement) {
        textlbl.text = model.title
        descLbl.text = model.desc
        if (model.image ?? "" ).isEmpty {
            widthConst.constant = 10
            
            imgView.rounded = true
            imgView.borderColorV = UIColor.appMango
            imgView.borderWidthV = 2
        } else {
            imgView.setImage(url: model.image ?? "")
            widthConst.constant = 20
            imgView.rounded = false
            
        }
    }

    typealias CellDataModel = Requirement
    @IBOutlet private var imgView: UIImageView!
    @IBOutlet private var descLbl: UILabel!
    @IBOutlet var textlbl: UILabel!
    @IBOutlet private var widthConst: NSLayoutConstraint!
    static let cellId = "VisaRequirementTableCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
