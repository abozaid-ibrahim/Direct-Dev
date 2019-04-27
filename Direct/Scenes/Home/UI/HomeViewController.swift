//
//  HomeViewController.swift
//  Direct
//
//  Created by abuzeid on 4/25/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController,StyledActionBar {
    private let homeViewModel = HomeViewModel()
    private let disposeBag = DisposeBag()
    private var collectionSecions: [HomeCollectionViewSection] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCollectionNibs()
        cellSize()
        self.setupActionBar(.withTitle("Direct Visa"))
        homeViewModel.collectionSecions.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{[weak self] data  in
                self?.collectionSecions.append(contentsOf: data)
                self?.collectionView.reloadData()
                } , onError: nil, onCompleted: nil, onDisposed: {
                    self.collectionSecions.removeAll()
            }).disposed(by: disposeBag)
        homeViewModel.getAllData()
        
    }
    private func cellSize(){
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        
        //Provide Width and Height According to your need
        let cellWidth = UIScreen.main.bounds.width
        let cellHeight = UIScreen.main.bounds.height / 4
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        //You can also provide estimated Height and Width
        layout.estimatedItemSize = CGSize(width: cellWidth, height: cellHeight)
        
        //For Setting the Spacing between cells
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
self.collectionView.collectionViewLayout = layout
    }
    
    private func registerCollectionNibs(){
//        ["OfferCollectionViewCell","InstituteCollectionViewCell","VisaCollectionViewCell","NewsCollectionViewCell"]
//            .forEach{
                collectionView.register(UINib(nibName: HomeCollectionSectionWrapper.cellId , bundle: nil), forCellWithReuseIdentifier: HomeCollectionSectionWrapper.cellId)
//        }
        collectionView.register(UINib(nibName: "HomeCollectionSectionHeader", bundle: nil), forSupplementaryViewOfKind:"UICollectionElementKindSectionHeader", withReuseIdentifier: "HomeCollectionSectionHeader")
    }
    
}
extension HomeViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collectionSecions.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HomeCollectionSectionHeader", for: indexPath) //as! HomeCollectionSectionHeader
        
//        sectionHeader.textLbl.text = "Section \(indexPath.section)"
        return sectionHeader
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellID = collectionSecions[indexPath.section].cellIdentifier
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionSectionWrapper.cellId, for: indexPath) as! HomeCollectionSectionWrapper
      
        
        
        cell.cellId = cellID
        return cell
    }
    
    
}
