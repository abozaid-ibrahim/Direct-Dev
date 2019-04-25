//
//  HomeCollectionCell.swift
//  Direct
//
//  Created by abuzeid on 4/25/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeCollectionViewSection {
    
    var  itemsCount:Int {get set}
    var cellIdentifier:String {get}
    var sectionTitle:String {get}
}
