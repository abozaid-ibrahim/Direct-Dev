//
//  OffersSectionVM.swift
//  Direct
//
//  Created by abuzeid on 4/25/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
class OffersSectionViewModel: HomeCollectionViewSection {
     var sectionTitle: String = "Offers And Packages"
    typealias Entity = String
    var itemsCount: Int = 0
    var cellIdentifier: String = "OfferCollectionViewCell"
    let items:[Entity]
    init(data:[Entity]) {
        self.items = data
        self.itemsCount = data.count
    }
}
