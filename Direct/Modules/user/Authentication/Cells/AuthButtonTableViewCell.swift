//
//  ButtonTableViewCell.swift
//  Daleel
//
//  Created by abdelrahman mohamed on 5/2/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import UIKit
import SnapKit

class AuthButtonTableViewCell: BaseTableViewCell {

    lazy var button: LoadingButton = {
        let view = LoadingButton()
        view.backgroundColor = #colorLiteral(red: 0.9874494672, green: 0.5041492581, blue: 0.00973271206, alpha: 1)
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.localizedFont = .bold(12)
        return view
    }()

    override func setupViews() {
        contentView.addSubview(button)
        selectionStyle = .none
        button.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(6)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40).priority(.medium)
        }
    }
}
