//
//  TitleCellController.swift
//  Daleel
//
//  Created by abdelrahman mohamed on 5/2/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import Foundation
import GenericCellControllers

class TitleCellController: GenericCellController<TitleTableViewCell> {

    private let data: String
    private let coordinator: AuthCoordinator

    init(_ data: String,
         coordinator: AuthCoordinator) {
        self.data = data
        self.coordinator = coordinator
    }

    override func configureCell(_ cell: TitleTableViewCell) {
        cell.textLabel?.text = data
    }
}
