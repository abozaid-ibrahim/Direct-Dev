//
//  TitleTableViewCell.swift
//  Daleel
//
//  Created by abdelrahman mohamed on 5/8/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import SnapKit
import UIKit

class TitleTableViewCell: BaseTableViewCell {
    
    override func setupViews() {
        super.setupViews()
        textLabel?.textAlignment = .center
        textLabel?.localizedFont = .bold(16)
        textLabel?.textColor = #colorLiteral(red: 0.3234693706, green: 0.3234777451, blue: 0.3234732151, alpha: 1)

    }
}
