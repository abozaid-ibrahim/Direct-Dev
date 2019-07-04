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
    typealias CellDataModel = (ReqInformation,isSection:Bool)
    @IBOutlet private var imgView: UIImageView!
    @IBOutlet var expandRow: UIImageView!
    @IBOutlet var textlbl: UILabel!

    let disposeBag = DisposeBag()
    @IBOutlet private var widthConst: NSLayoutConstraint!
    static let cellId = "VisaRequirementTableCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func setCellData(_ obj: CellDataModel) {
        textlbl.font = obj.isSection ? UIFont.appBoldFontWith(size:  14) : UIFont.appRegularFontWith(size:  14)

        let model = obj.0
        textlbl.text = model.title
        
        if (model.icon ?? "").isEmpty {
            widthConst.constant = 5
            imgView.layer.cornerRadius = 2.4
            imgView.borderColorV = UIColor.appMango
            imgView.borderWidthV = 2.4
        } else {
            imgView.setImage(with: model.icon ?? "")
            widthConst.constant = 20
            imgView.backgroundColor = .clear
            imgView.borderWidthV = 0
        }
    }
}
