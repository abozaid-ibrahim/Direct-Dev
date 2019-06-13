//
//  AuthCellControllerFactory.swift
//  Daleel
//
//  Created by abdelrahman mohamed on 5/2/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Foundation
import GenericCellControllers

struct AuthCellControllerFactory {
    func registerCells(on tableView: UITableView) {
        // The factory is the only one who knows the exact Cell Controllers we are using, hence,
        // it is responsible for registering them in the UITableView/UICollectionView
        AuthButtonCellController.registerCell(on: tableView)
        AuthTextFieldCellController.registerCell(on: tableView)
        TextLabelCellController.registerCell(on: tableView)
        PhoneNumberCellController.registerCell(on: tableView)
        TitleCellController.registerCell(on: tableView)
    }

    func cellControllers(from elements: [AuthElement], coordinator: AuthCoordinator) -> [TableCellController] {
        // Matching each type of data to the right Cell Controller is now something we only do once. Here.

        return elements.map { element in
            switch element {
            case let .title(str):
                return TitleCellController(str, coordinator: coordinator)
            case let .button(config):
                return AuthButtonCellController(config, coordinator: coordinator)
            case let .textField(config):
                return AuthTextFieldCellController(config, coordinator: coordinator)
            case let .phoneNumber(conf):
                return PhoneNumberCellController(conf, coordinator: coordinator)
            case let .textLabel(conf):
                return TextLabelCellController(conf, coordinator: coordinator)
            }
        }
    }
}
