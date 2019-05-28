//
//  HomeViewModel.swift
//  Hero
//
//  Created by abuzeid on 4/25/19.
//

import Foundation
import RxSwift

class HomeViewModel {
    var itemsCount: Int = 4
    var collectionSecions: PublishSubject<[HomeCollectionViewSection]> = PublishSubject<[HomeCollectionViewSection]>()
    func getAllData() {
        var items = [HomeCollectionViewSection]()
        items.append(VisaRequirementViewModel(data: ["Test", "blaaaa"]))
        items.append(InstitutesSectionViewModel(data: ["Test", "blaaaa"]))
        items.append(OffersSectionViewModel(data: ["Test", "blaaaa", "Test", "blaaaa", "Test", "blaaaa", "Test", "blaaaa"]))

        items.append(NewsSectionViewModel(data: ["Test", "blaaaa"]))
        collectionSecions.onNext(items)
    }
}
