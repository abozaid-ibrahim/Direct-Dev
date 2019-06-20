//
//  VisaRequirementTableCell.swift
//  Direct
//
//  Created by abuzeid on 4/28/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import UIKit

class VisaRequirementTableCell: UITableViewCell, TableCell {
    typealias CellDataModel = Requirement
    @IBOutlet private var imgView: UIImageView!
    @IBOutlet var expandRow: UIImageView!
    @IBOutlet var textlbl: UILabel!

    let disposeBag = DisposeBag()
    @IBOutlet private var widthConst: NSLayoutConstraint!
    static let cellId = "VisaRequirementTableCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        textlbl.font = UIFont.appBoldFontWith(size: 14)
    }

    func setCellData(_ model: Requirement) {
        textlbl.text = model.title
        if (model.image ?? "").isEmpty {
            widthConst.constant = 10

            imgView.layer.cornerRadius = 4.9
            imgView.borderColorV = UIColor.appMango
            imgView.borderWidthV = 2
        } else {
            imgView.setImage(with: model.image ?? "")
            widthConst.constant = 20
            imgView.backgroundColor = .clear
            imgView.rounded = false
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
