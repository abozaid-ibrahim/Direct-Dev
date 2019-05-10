//
//  SpinnerTextField.swift
//  Direct
//
//  Created by abuzeid on 4/29/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import RxSwift
import RxGesture

@IBDesignable
class SpinnerTextField: UIView {
    let txtField = UITextField()
    private let leftLogo = UIImageView()
    private let rightLogo = UIImageView()

    @IBInspectable var leftImage: UIImage? {
        didSet {
            leftLogo.image = leftImage
        }
    }

    @IBInspectable var rightImage: UIImage? {
        didSet {
            rightLogo.image = rightImage
        }
    }

    @IBInspectable var hint: String? {
        didSet {
            txtField.placeholder = hint ?? ""
        }
    }
let disposeBag = DisposeBag()
    typealias Action = () -> Void
    var action: Action?
    func setOnclick(ac: @escaping Action) {
//        action = ac
//        let tap = UITapGestureRecognizer(target: self, action: #selector(clicked(sender:)))
//        addGestureRecognizer(tap)
//        self.rx.tapGesture().subscribe{
//            ac()
//            }.disposed(by: disposeBag)
    }

    @objc private func clicked(sender _: Any) {
        action?()
    }

    private func createUI() {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = 10
        leftLogo.translatesAutoresizingMaskIntoConstraints = false
        leftLogo.widthAnchor.constraint(equalToConstant: 25).isActive = true
        leftLogo.contentMode = .scaleAspectFit

        rightLogo.translatesAutoresizingMaskIntoConstraints = false
        rightLogo.widthAnchor.constraint(equalToConstant: 25).isActive = true
        rightLogo.contentMode = .scaleAspectFit

        stack.addArrangedSubview(leftLogo)
        stack.addArrangedSubview(txtField)
        stack.addArrangedSubview(rightLogo)

        addSubview(stack)
        stack.sameBoundsTo(parentView: self, l: 10, tr: 10)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        createUI()
        backgroundColor = UIColor.appOffWhite
        cornerRadiusV = 8
    }
}
