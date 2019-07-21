//
//  CountryTableCell.swift
//  Direct
//
//  Created by abuzeid on 4/29/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class CountryTableCell: UITableViewCell, TableCell {
    func setCellData(_ model: CellDataModel) {
        logoView.setImage(with: model.flag ?? "")
        textLbl.text = model.countryName
    }

    typealias CellDataModel = NewVisaServices

    @IBOutlet private var logoView: UIImageView!
    @IBOutlet private var textLbl: UILabel!
    static let cellId = "CountryTableCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
