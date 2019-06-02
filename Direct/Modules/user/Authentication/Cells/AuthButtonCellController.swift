//
//  AuthButtonCellController.swift
//  Daleel
//
//  Created by abdelrahman mohamed on 5/2/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Foundation
import GenericCellControllers

class AuthButtonCellController: GenericCellController<AuthButtonTableViewCell> {

    private let data: ButtonCellConfigurator
    private let coordinator: AuthCoordinator
    private var timer: Timer?
    init(_ data: ButtonCellConfigurator,
         coordinator: AuthCoordinator) {
        self.data = data
        self.coordinator = coordinator
    }

   

    override func configureCell(_ cell: AuthButtonTableViewCell) {
        // Easy configuration since the Cell Controller receive the right type of cell and
        // it is already holding the data this cell needs to display.
        cell.button.setTitle(data.title, for: .normal)
        cell.button.setTitleColor(data.titleColor, for: .normal)
        cell.button.layer.borderWidth = data.borderWidth
        cell.button.layer.borderColor = data.borderColor.cgColor
        cell.button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        cell.backgroundColor = .clear

    }

    override func didSelectCell() {
        // We can call the right method in the coordinator since the Cell Controller only deals
        // with one type of data.

    }

    @objc func didTapButton(_ sender: LoadingButton) {
        coordinator.didTap(button: sender, data: data)
    }
}
