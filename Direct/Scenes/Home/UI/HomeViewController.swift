//
//  HomeViewController.swift
//  Direct
//
//  Created by abuzeid on 4/25/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,StyledActionBar {
    private let homeViewModel = HomeViewModel()
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupActionBar(.withTitle("Direct Visa"))
    }
    
    
    
}
extension HomeViewController:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return homeViewModel.collectionSecions.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.collectionSecions[section].itemsCount
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader{
//            sectionHeader.sectionHeaderlabel.text = "Section \(indexPath.section)"
            return sectionHeader
        }
        return UICollectionReusableView()
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeViewModel.collectionSecions[indexPath.section].cellIdentifier, for: indexPath)
        return cell
    }
    
    
}
class SectionHeader: UICollectionReusableView {
     var sectionHeaderlabel: UILabel!{
        let lbl = UILabel()
        lbl.backgroundColor = .red
        lbl.text = "adfasdf"
        return lbl
    }
    
}
