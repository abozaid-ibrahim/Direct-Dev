//
//  VisaConfrimationPassangerCell.swift
//  Direct
//
//  Created by abuzeid on 6/24/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import RxSwift
class VisaConfrimationPassangerCell: UITableViewCell {
    let disposeBag = DisposeBag()
    static let id = "VisaConfrimationPassangerCell"
    @IBOutlet var textLbl: UILabel!
    @IBOutlet var statuxIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
    }
}
