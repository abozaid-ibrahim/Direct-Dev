//
//  HomeCollectionSectionWrapper.swift
//  Direct
//
//  Created by abuzeid on 4/27/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class HomeCollectionSectionWrapper: UICollectionViewCell {
    static let cellId = "HomeCollectionSectionWrapper"
    @IBOutlet weak var collectionView: UICollectionView!

    var cellId:String!{
        didSet{
            self.collectionView.register(UINib(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
        }
    }
//    init(_ cellIdentifier: String) {
//        cellId  = cellIdentifier
//
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        cellSize()
    }
    
    private func cellSize(){
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        
        //Provide Width and Height According to your need
        let cellWidth =  300
        let cellHeight = 200
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        //You can also provide estimated Height and Width
        layout.estimatedItemSize = CGSize(width: cellWidth, height: cellHeight)
        
        //For Setting the Spacing between cells
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        self.collectionView.collectionViewLayout = layout
    }
    
}
extension HomeCollectionSectionWrapper:UICollectionViewDataSource,UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
   
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        return cell
    }
    
    
}
