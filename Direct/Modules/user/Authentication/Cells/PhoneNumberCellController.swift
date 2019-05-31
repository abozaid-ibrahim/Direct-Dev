//
//  PhoneNumberCellController.swift
//  Daleel
//
//  Created by abdelrahman mohamed on 5/2/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Foundation
import GenericCellControllers

class PhoneNumberCellController: GenericCellController<PhoneNumberTableViewCell> {

    private let data: TextFieldConfigurator
    private var coordinator: AuthCoordinator
    private var cell: PhoneNumberTableViewCell?

    init(_ data: TextFieldConfigurator,
         coordinator: AuthCoordinator) {
        self.data = data
        self.coordinator = coordinator
    }

    var phoneData = [String: String]()

    override func configureCell(_ cell: PhoneNumberTableViewCell) {
        self.cell = cell
        cell.textField.placeholder = data.placeHolder
        cell.textField.keyboardType = data.keyboardType
        cell.textField.isSecureTextEntry = data.isSecured
        cell.textField.textContentType = data.inputType
        cell.textField.addTarget(self, action: #selector(didUpdateText), for: .editingDidEnd)
        cell.textField.text = coordinator.collectedData[data.type.rawValue]
    }

    override func didSelectCell() {
        // We can call the right method in the coordinator since the Cell Controller only deals
        // with one type of data.
    }

    @objc func didUpdateText() {
        guard let phone = cell?.textField.text else {
            return
        }

        phoneData = [
            AuthCellType.phonenumber.rawValue: phone
        ]
        coordinator.textChanged(values: phoneData)
    }
}
