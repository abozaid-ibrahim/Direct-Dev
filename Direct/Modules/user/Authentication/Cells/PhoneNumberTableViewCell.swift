//
//  PhoneNumberTableViewCell.swift
//  Daleel
//
//  Created by abdelrahman mohamed on 5/7/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import UIKit

class PhoneNumberTableViewCell: BaseTableViewCell {
    lazy var backView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9763646722, green: 0.9765316844, blue: 0.9763541818, alpha: 1)
        view.addSubview(self.textField)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()

    lazy var textField: UITextField = { [unowned self] in
        let tf = UITextField()
        tf.localizedFont = .bold(12)
        return tf
    }()

    override func setupViews() {
        addSubview(backView)
        selectionStyle = .none
        backView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }

        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        textField.text = nil
    }
}
