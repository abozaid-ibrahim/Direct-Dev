//
//  ReqDescTableCell.swift
//  Direct
//
//  Created by abuzeid on 6/8/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class ReqDescTableCell: UITableViewCell, TableCell {
    static let cellId = "ReqDescTableCell"
    typealias CellDataModel = (txt:String,img:String?)
    @IBOutlet weak var heightConstrain: NSLayoutConstraint!
    @IBOutlet private var txtLbl: UILabel!
    @IBOutlet private  weak var imgView: UIImageView!
    func setCellData(_ model: CellDataModel) {
        txtLbl.text = model.txt
        if let url  = model.img , url.isValidUrl{
            imgView.isHidden = false
            imgView.setImage(with: url)
            heightConstrain.constant = 120
        }else{
            imgView.isHidden = true
            heightConstrain.constant = 0
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        txtLbl.font = .appRegularFontWith(size: 12)
    }


}
