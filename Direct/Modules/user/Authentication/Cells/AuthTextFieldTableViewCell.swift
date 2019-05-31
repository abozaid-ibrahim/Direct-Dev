//
//  TextFieldTableViewCell.swift
//  Daleel
//
//  Created by abdelrahman mohamed on 5/2/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import UIKit
import SnapKit

class AuthTextFieldTableViewCell: BaseTableViewCell {

    lazy var backView: UIView = {[unowned self] in
        let view = UIView()
        view.layer.borderColor = #colorLiteral(red: 0.8797392845, green: 0.8797599673, blue: 0.8797488809, alpha: 1).cgColor
        view.layer.borderWidth = 1
        view.addSubview(self.stackHolder)
        view.layer.cornerRadius = 22
        view.clipsToBounds = true
        return view
    }()

    lazy var textField: UITextField = {
        let view = UITextField()
        view.adjustsFontSizeToFitWidth = true
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.textAlignment = .center
        view.localizedFont = .bold(12)
        view.delegate = self
        return view
    }()

    lazy var passwordBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "password"), for: .normal)
        button.isHidden = true
        button.tintColor = .gray
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(showPassword(sender:)), for: .touchUpInside)
        return button
    }()

    lazy var stackHolder: UIStackView = {[unowned self] in
        let stack = UIStackView(arrangedSubviews: [self.textField, self.passwordBtn])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()

    @objc func showPassword(sender: UIButton) {
        textField.isSecureTextEntry.toggle()
        let image = textField.isSecureTextEntry ? #imageLiteral(resourceName: "password") :  #imageLiteral(resourceName: "show-password")
        sender.setImage(image, for: .normal)
    }

    var textType: AuthCellType?

    override func setupViews() {
        selectionStyle = .none
        self.contentView.addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }

        stackHolder.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }
        passwordBtn.snp.makeConstraints { (make) in
            make.width.equalTo(35)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        textField.text = nil
    }
}

extension AuthTextFieldTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let type = textType, type == AuthCellType.phoneConfirmNumber {
            let maxLength = 4
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return true
    }
}
