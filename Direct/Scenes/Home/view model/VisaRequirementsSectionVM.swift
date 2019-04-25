//
//  VisaRequirementsSectionVM.swift
//  Direct
//
//  Created by abuzeid on 4/25/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
final class VisaRequirementViewModel: HomeCollectionViewSection{
     var sectionTitle: String = "Visa"
    typealias Entity = String
    var itemsCount: Int = 0
    var cellIdentifier: String = "VisaCollectionViewCell"
    let items:[Entity]
    init(data:[Entity]) {
        self.items = data
        self.itemsCount = data.count
    }
    
}
