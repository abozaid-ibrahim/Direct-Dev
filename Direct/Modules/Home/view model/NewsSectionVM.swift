//
//  NewsSectionViewModel.swift
//  Direct
//
//  Created by abuzeid on 4/25/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

final class NewsSectionViewModel: HomeCollectionViewSection {
    var sectionTitle: String = "NEWS"

    typealias Entity = String
    var itemsCount: Int = 0
    var cellIdentifier: String = "NewsCollectionViewCell"
    let items: [Entity]
    init(data: [Entity]) {
        items = data
        itemsCount = data.count
    }
}
