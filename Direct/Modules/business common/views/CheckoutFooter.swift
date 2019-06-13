//
//  CheckoutFooter.swift
//  Direct
//
//  Created by abuzeid on 4/30/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import UIKit
@IBDesignable
class CheckoutFooter: UIView {
    var footer: CheckoutBottomView!
    @IBInspectable var btnTitle: String? {
        didSet {
            footer.actionBtn.setTitle(btnTitle ?? "", for: .normal)
        }
    }

    @IBInspectable var placeHolder: String? {
        didSet {
            footer.hintLbl.text = placeHolder ?? ""
        }
    }

    @IBInspectable var valueText: String? {
        didSet {
            footer.valueLbl.text = valueText
        }
    }

    var bg: UIColor? {
        didSet {
            backgroundColor = bg
            footer.backgroundColor = bg
        }
    }

    typealias Action = () -> Void
    var action: Action?
    func setOnclick(ac: @escaping Action) {
        action = ac
    }

    private func bindUI() {
        footer = loadNib(name: "CheckoutBottomView") as? CheckoutBottomView
        addSubview(footer)
        footer.sameBoundsTo(parentView: self)
        footer.actionBtn.rx.tap.bind { [weak self] in
            self?.action?()
        }.disposed(by: bag)
    }

    private let bag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        bindUI()
//        self.backgroundColor = UIColor.appOffWhite
//        self.cornerRadiusV = 8
    }
}
