//
//  AuthTextFieldCellController.swift
//  Daleel
//
//  Created by abdelrahman mohamed on 5/2/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Foundation
import GenericCellControllers

class TextLabelCellController: GenericCellController<TextLabelTableViewCell> {

    private let data: TextLabelConfigurator
    private let coordinator: AuthCoordinator

    init(_ data: TextLabelConfigurator,
         coordinator: AuthCoordinator) {
        self.data = data
        self.coordinator = coordinator
    }

    override func configureCell(_ cell: TextLabelTableViewCell) {
        if let attributed = data.attributedText {
            cell.textLabel?.attributedText = attributed
        } else {
            cell.textLabel?.text = data.text
            cell.textLabel?.font = data.font
            cell.textLabel?.textColor = data.textColor
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.textAlignment = data.textAlign!
        }
        cell.selectionStyle = .none
        
    }

    override func didSelectCell() {
        coordinator.labelClicked(type: data.type)
    }

}
