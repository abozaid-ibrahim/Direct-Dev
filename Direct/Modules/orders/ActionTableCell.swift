//
//  ActionTableCell.swift
//  Direct
//
//  Created by abuzeid on 7/8/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import UIKit
class ActionTableCell: UITableViewCell, TableCell {
    typealias CellDataModel = (String, style: ButtonStyles)
    static var cellId: String = "ActionTableCell"
    var disposeBag = DisposeBag()
    
    func setCellData(_ model: CellDataModel) {
        submitBtn.setTitle(model.0, for: .normal)
        submitBtn.applyStyle(model.style)
    }

    @IBOutlet var submitBtn: UIButton!
override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
