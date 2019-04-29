//
//  TableCell.swift
//  Direct
//
//  Created by abuzeid on 4/29/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

protocol TableCell {
    associatedtype CellDataModel
    static var cellId:String {get}
    func setCellData(_ model:CellDataModel)
}
