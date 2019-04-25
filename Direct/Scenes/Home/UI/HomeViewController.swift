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
    
    private func registerCollectionNibs(){
        ["OfferCollectionViewCell","InstituteCollectionViewCell","VisaCollectionViewCell","NewsCollectionViewCell"]
            .forEach{
                collectionView.register(UINib(nibName: $0, bundle: nil), forCellWithReuseIdentifier: $0)
        }
        collectionView.register(UINib(nibName: "HomeCollectionSectionHeader", bundle: nil), forSupplementaryViewOfKind:"UICollectionElementKindSectionHeader", withReuseIdentifier: "HomeCollectionSectionHeader")
    }
    
}
extension HomeViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collectionSecions.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionSecions[section].itemsCount
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HomeCollectionSectionHeader", for: indexPath) //as! HomeCollectionSectionHeader
        
//        sectionHeader.textLbl.text = "Section \(indexPath.section)"
        return sectionHeader
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionSecions[indexPath.section].cellIdentifier, for: indexPath)
        
        return cell
    }
    
    
}
