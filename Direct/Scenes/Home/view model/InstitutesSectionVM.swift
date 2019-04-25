//
//  InstitutesSectionVM.swift
//  Direct
//
//  Created by abuzeid on 4/25/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
class InstitutesSectionViewModel: HomeCollectionViewSection {
    typealias Entity = String
     var sectionTitle: String = "Institutes"
    var itemsCount: Int = 0
    var cellIdentifier: String = "InstituteCollectionViewCell"
    let items:[Entity]
    init(data:[Entity]) {
        self.items = data
        self.itemsCount = data.count
    }
}
