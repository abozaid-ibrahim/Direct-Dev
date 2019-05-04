//
//  CountryTableCell.swift
//  Direct
//
//  Created by abuzeid on 4/29/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class CountryTableCell: UITableViewCell, TableCell {
    func setCellData(_ model: (String, UIImage)) {
        logoView.image = model.1
        textLbl.text = model.0
    }

    typealias CellDataModel = (String, UIImage)

    @IBOutlet private var logoView: UIImageView!
    @IBOutlet private var textLbl: UILabel!
    static let cellId = "CountryTableCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
