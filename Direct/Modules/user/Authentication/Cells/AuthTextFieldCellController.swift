//
//  AuthTextFieldCellController.swift
//  Daleel
//
//  Created by abdelrahman mohamed on 5/2/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Foundation
import GenericCellControllers

class AuthTextFieldCellController: GenericCellController<AuthTextFieldTableViewCell> {

    private let data: TextFieldConfigurator
    private var coordinator: AuthCoordinator

    init(_ data: TextFieldConfigurator,
         coordinator: AuthCoordinator) {
        self.data = data
        self.coordinator = coordinator
    }

    override func configureCell(_ cell: AuthTextFieldTableViewCell) {
        // Easy configuration since the Cell Controller receive the right type of cell and
        // it is already holding the data this cell needs to display.
        cell.textField.placeholder = data.placeHolder
        cell.textField.keyboardType = data.keyboardType
        cell.textField.isSecureTextEntry = data.isSecured
        cell.textField.textContentType = data.inputType
        cell.textField.text = coordinator.collectedData[data.type.rawValue]
        cell.passwordBtn.isHidden = !data.isSecured
        cell.textField.addTarget(self, action: #selector(didUpdateText(_:)), for: .editingDidEnd)
        cell.textType = data.type
    }

    @objc func didUpdateText(_ sender: UITextField) {
        guard let value = sender.text else { return }
        coordinator.textChanged(values: [data.type.rawValue: value])
    }

}
