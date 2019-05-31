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
    @IBOutlet var collectionView: UICollectionView!
    var cellWidth: CGFloat!
    var cellId: String! {
        didSet {
            self.collectionView.register(UINib(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
        }
    }

//
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self //
        collectionView.backgroundColor = UIColor.appVeryLightPink
        backgroundColor = UIColor.appVeryLightPink

        // getdata//
    }

    func getData(params _: Any) {
        /// exd
    }
}

extension HomeCollectionSectionWrapper: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: bounds.height - 4)
    }

    func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return dataList.count
    }

    func collectionView(_: UICollectionView, didSelectItemAt _: IndexPath) {
//        try! AppNavigator().push(Destination.visaRequirement)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.cornerRadiusV = 10
        cell.clipsToBounds = true
        return cell
    }
}
