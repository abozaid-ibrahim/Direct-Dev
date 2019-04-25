//
//  HomeViewModel.swift
//  Hero
//
//  Created by abuzeid on 4/25/19.
//

import Foundation
class HomeViewModel {
    var itemsCount:Int = 4
    var collectionSecions = [HomeCollectionViewSection]()
    func getAllData(){
        self.collectionSecions.append(VisaRequirementViewModel(data: ["Test","blaaaa"]))
         self.collectionSecions.append(InstitutesSectionViewModel(data: ["Test","blaaaa"]))
        self.collectionSecions.append(OffersSectionViewModel(data: ["Test","blaaaa"]))

         self.collectionSecions.append(NewsSectionViewModel(data: ["Test","blaaaa"]))
    }
}
