//
//  TagView.swift
//  TagsUIView
//
//  Created by abuzeid on 5/18/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

import UIKit
enum TagViewAligment {
    case left, right
}

protocol TagsView {}
public typealias TagDataModel = (String, UIImage?)
@IBDesignable
public class TagView: UIView, TagsView {
    var aligment: TagViewAligment = .right {
        didSet {
            switch self.aligment {
            case .left:
                self.layout.horizontalAlignment = .left
            case .right:
                self.layout.horizontalAlignment = .right
            }
        }
    }

    @IBInspectable
    public var font: UIFont = UIFont.systemFont(ofSize: 10)

    @IBInspectable
    public var textColor: UIColor = .black

    @IBInspectable
    public var bgColor: UIColor = .white

    @IBInspectable
    public var borderColor: UIColor = .lightGray

    @IBInspectable
    public var inimumInteritemSpacing = 10

    @IBInspectable
    public var minimumLineSpacing = 10

    private let layout: AlignedCollectionViewFlowLayout = {
        let layout = AlignedCollectionViewFlowLayout()
        layout.horizontalAlignment = .leading
        layout.scrollDirection = .vertical
        if #available(iOS 10.0, *) {
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        } else {
            layout.estimatedItemSize = CGSize(width: 100, height: 28)
        }
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

        return layout
    }()

    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collection.backgroundColor = .white
        return collection
    }()

    public var items: [TagDataModel] = []
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(tags: [TagDataModel]) {
        super.init(frame: CGRect.zero)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    func setup() {
        backgroundColor = .white
        self.addCollectionView()
        let bundle = Bundle(for: type(of: self))
        collectionView.register(UINib(nibName: TagCollectionCell.id, bundle: bundle), forCellWithReuseIdentifier: TagCollectionCell.id)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
    }

    private func addCollectionView() {
        self.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: self.collectionView.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: self.collectionView.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: self.collectionView.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: self.collectionView.bottomAnchor).isActive = true
    }
}

extension TagView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
}

extension TagView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }

    public func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.font = self.font
        label.text = self.items[indexPath.row].0
        let iconWidth = self.items[indexPath.row].1 == nil ? 8 : CGFloat(25)
        label.sizeToFit()
        let size = label.frame.size
        let padding = CGFloat(12)
        return CGSize(width: size.width + iconWidth + padding, height: 30)
    }
}

extension TagView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionCell.id, for: indexPath) as! TagCollectionCell
        cell.setCellModel(model: self.items[indexPath.row])
        cell.setFont(self.font, bgColor: self.bgColor, txtColor: self.textColor)
        return cell
    }
}
