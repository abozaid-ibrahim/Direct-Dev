//
//  HomeViewController.swift
//  Direct
//
//  Created by abuzeid on 4/25/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import RxSwift

private typealias HeaderObject = (UIImage,String)

final class HomeViewController: UIViewController, StyledActionBar {
    
    

    private let homeViewModel = HomeViewModel()
    private let disposeBag = DisposeBag()
    private let sectionsHeaderData :[HeaderObject] = [(#imageLiteral(resourceName: "p"), "Visa"),(#imageLiteral(resourceName: "p"), "Visa"),(#imageLiteral(resourceName: "p"), "Visa"),(#imageLiteral(resourceName: "p"), "Visa"),(#imageLiteral(resourceName: "p"), "Visa")]
    private var collectionSecions: [HomeCollectionViewSection] = []
    private let sectionsCellSize : [CGSize] = [CGSize(width: 147,height: 113),CGSize(width: 292,height: 171),CGSize(width: 292,height: 226),CGSize(width: 292,height: 171)]
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private var visaView: UIStackView!
    @IBOutlet private weak var contentLayout: UIView!
    
    @IBOutlet weak var instituteView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appVeryLightPink
        collectionView.delegate = self
        registerCollectionNibs()
        self.setupActionBar(.withTitle("Direct Visa"))
        getDataFromViewModel()
        homeViewModel.getAllData()
        let gest  = UITapGestureRecognizer(target: self, action: #selector(visaDidSelected(_:)))
//        instituteView.addGestureRecognizer(gest)
        
    }
    private func getDataFromViewModel(){
        homeViewModel.collectionSecions.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{[weak self] data  in
                self?.collectionSecions.append(contentsOf: data)
                self?.collectionView.reloadData()
                } , onError: nil, onCompleted: nil, onDisposed: {
                    self.collectionSecions.removeAll()
            }).disposed(by: disposeBag)
    }
    private func registerCollectionNibs(){
        collectionView.register(UINib(nibName: HomeCollectionSectionWrapper.cellId , bundle: nil), forCellWithReuseIdentifier: HomeCollectionSectionWrapper.cellId)
        collectionView.register(UINib(nibName: "HomeCollectionSectionHeader", bundle: nil), forSupplementaryViewOfKind:"UICollectionElementKindSectionHeader", withReuseIdentifier: "HomeCollectionSectionHeader")
    }
    @objc func visaDidSelected(_ sender: Any) {
        let vc  = NewDirectVisaController()
        self.addChild(vc)
        contentLayout.addSubview(vc.view)
        vc.view.sameBoundsTo(parentView: contentLayout)
        collectionView.isHidden = true
    }
    @IBAction func institutesDidSelected(_ sender: Any) {
    }
    
    @IBAction func packagesDidSelect(_ sender: Any) {
        
    }
}
extension HomeViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collectionSecions.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HomeCollectionSectionHeader", for: indexPath)        
        //                sectionHeader.textLbl.text = sectionsHeaderData[indexPath.section].1
        return sectionHeader
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.collectionView.bounds.width, height: CGFloat(sectionsCellSize[indexPath.section].height))
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellID = collectionSecions[indexPath.section].cellIdentifier
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionSectionWrapper.cellId, for: indexPath) as! HomeCollectionSectionWrapper
        
        cell.cellWidth = sectionsCellSize[indexPath.section].width
        
        cell.cellId = cellID
        return cell
    }
    
    
}
