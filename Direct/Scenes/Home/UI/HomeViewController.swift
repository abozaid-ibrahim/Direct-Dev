//
//  HomeViewController.swift
//  Direct
//
//  Created by abuzeid on 4/25/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxGesture
import RxSwift
import UIKit

private typealias HeaderObject = (UIImage, String)
final class HomeViewController: UIViewController, StyledActionBar {
    @IBOutlet var packageView: UIStackView!
    @IBOutlet var institueView: UIStackView!
    private let homeViewModel = HomeViewModel()
    var disposeBag = DisposeBag()
    private let sectionsHeaderData: [HeaderObject] = [(#imageLiteral(resourceName: "p"), "متطلبات التأشيرة"), (#imageLiteral(resourceName: "p"), "أفضل المعاهد "), (#imageLiteral(resourceName: "p"), "بكجات وعروض"), (#imageLiteral(resourceName: "p"), "أخبار ومعلومات"), (#imageLiteral(resourceName: "p"), "Visa")]
    private var collectionSecions: [HomeCollectionViewSection] = []
    private let sectionsCellSize: [CGSize] = [CGSize(width: 147, height: 113), CGSize(width: 292, height: 171), CGSize(width: 292, height: 226), CGSize(width: 292, height: 171)]

    @IBOutlet var containerView: UIView!
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var headerView: UIView!
    @IBOutlet var headerWidthConstrain: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appVeryLightPink
        collectionView.backgroundColor = UIColor.appVeryLightPink

        collectionView.delegate = self
        registerCollectionNibs()
        setupActionBar(.withTitle("دايركت فيزا"))
        getDataFromViewModel()
        homeViewModel.getAllData()
    }

    @IBAction func institureAction(_: Any) {
        if children.contains(newInstitue) {
            newInstitue.dismissWithAnim()
        } else {
            tabbarSelected(vc: newInstitue)
        }
    }

    @IBAction func packagesDidSelect(_: Any) {
        let vc = packagesVC as! PackagesViewController
        if children.contains(vc) {
            newInstitue.dismissWithAnim()
        } else {
            vc.dismissable = true
            tabbarSelected(vc: vc)
        }
    }

    private func getDataFromViewModel() {
        homeViewModel.collectionSecions.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                self?.collectionSecions.append(contentsOf: data)
                self?.collectionView.reloadData()
            }, onError: nil, onCompleted: nil, onDisposed: {
                self.collectionSecions.removeAll()
            }).disposed(by: disposeBag)
    }

    private func registerCollectionNibs() {
        collectionView.register(UINib(nibName: HomeCollectionSectionWrapper.cellId, bundle: nil), forCellWithReuseIdentifier: HomeCollectionSectionWrapper.cellId)
        collectionView.register(UINib(nibName: "HomeCollectionSectionHeader", bundle: nil), forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: "HomeCollectionSectionHeader")
    }

    let vc = NewDirectVisaController()
    let newInstitue = NewInstituteRequestController()
    let packagesVC = UIStoryboard.main.instantiateViewController(withIdentifier: "PackagesViewController")

    @IBAction func visaDidSelected(_: Any) {
        if children.contains(vc) {
            newInstitue.dismissWithAnim()
        } else {
            tabbarSelected(vc: vc)
        }
    }

    private func tabbarSelected(vc: SwipeUpDismissable) {
        addChild(vc)
        containerView.addSubview(vc.view)
        vc.dismessed.asObservable().subscribe(onNext: { [weak self] dismessed in
            guard let self = self else { return }
            self.collectionView.isHidden = !dismessed
            self.updateHeaderFrame(fullWidth: !dismessed)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)

        startViewsAnim(vc)
    }

    private func startViewsAnim(_ vc: UIViewController) {
        let childFrame = containerView.frame
        vc.view.frame = CGRect(x: childFrame.minX, y: -childFrame.height, width: childFrame.width, height: childFrame.height)
        UIView.animate(withDuration: 0.3, animations: {
            vc.view.frame = self.containerView.bounds
        }, completion: nil)
        updateHeaderFrame(fullWidth: true)
    }

    private func updateHeaderFrame(fullWidth: Bool) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self = self else { return }
            if fullWidth {
                self.headerView.layer.cornerRadius = 0
                self.headerWidthConstrain.constant = self.headerView.superview!.bounds.width
            } else {
                self.headerView.layer.cornerRadius = 30
                self.headerView.clipsToBounds = true
                self.headerWidthConstrain.constant = 300
            }
        }, completion: nil)
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in _: UICollectionView) -> Int {
        return collectionSecions.count
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HomeCollectionSectionHeader", for: indexPath)
        
        


        guard let header = sectionHeader as? HomeCollectionSectionHeader else {
            return sectionHeader
        }
        header.textLbl.text = sectionsHeaderData[indexPath.section].1
        return header
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: CGFloat(sectionsCellSize[indexPath.section].height))
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellID = collectionSecions[indexPath.section].cellIdentifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionSectionWrapper.cellId, for: indexPath) as! HomeCollectionSectionWrapper
        cell.cellWidth = sectionsCellSize[indexPath.section].width
        cell.cellId = cellID
        return cell
    }
}
