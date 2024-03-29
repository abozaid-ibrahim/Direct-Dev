//
//  TextFieldTableViewCell.swift
//  Daleel
//
//  Created by abdelrahman mohamed on 5/2/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import SnapKit
import UIKit

class AuthTextFieldTableViewCell: BaseTableViewCell {
    lazy var backView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9763646722, green: 0.9765316844, blue: 0.9763541818, alpha: 1)
        view.addSubview(self.stackHolder)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()

    lazy var textField: UITextField = {
        let view = UITextField()
        view.adjustsFontSizeToFitWidth = true
        view.autocorrectionType = .no
        view.backgroundColor = #colorLiteral(red: 0.9763646722, green: 0.9765316844, blue: 0.9763541818, alpha: 1)
        view.autocapitalizationType = .none
        view.localizedFont = .bold(12)
        view.delegate = self
        return view
    }()

    lazy var passwordBtn: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icons8Eye"), for: .normal)
        button.isHidden = true
        button.tintColor = .gray
        button.backgroundColor = #colorLiteral(red: 0.9763646722, green: 0.9765316844, blue: 0.9763541818, alpha: 1)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(showPassword(sender:)), for: .touchUpInside)
        return button
    }()

    lazy var stackHolder: UIStackView = { [unowned self] in
        let stack = UIStackView(arrangedSubviews: [self.textField, self.passwordBtn])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()

    @objc func showPassword(sender _: UIButton) {
        textField.isSecureTextEntry.toggle()
    }

    var textType: AuthCellType?

    override func setupViews() {
        super.setupViews()
        contentView.addSubview(backView)

        
        backView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }

        stackHolder.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        passwordBtn.snp.makeConstraints { make in
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
