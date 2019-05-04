//
//  VisaRequirementsSectionVM.swift
//  Direct
//
//  Created by abuzeid on 4/25/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxSwift

final class VisaRequirementViewModel: HomeCollectionViewSection {
    var sectionTitle: String = "Visa"
    typealias Entity = String
    var itemsCount: Int = 0
    var cellIdentifier: String = "VisaCollectionViewCell"
    let items: [Entity]
    init(data: [Entity]) {
        items = data
        itemsCount = data.count
    }
}
