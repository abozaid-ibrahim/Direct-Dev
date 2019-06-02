//
//  SpinnerTextField.swift
//  Direct
//
//  Created by abuzeid on 4/29/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxGesture
import RxSwift
import UIKit

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

    var text = PublishSubject<String?>()
    let disposeBag = DisposeBag()
    typealias Action = () -> Void
    var action: Action?
    func setOnclick(ac _: @escaping Action) {
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
        txtField.font = UIFont(name: UIFont.familyNames.first!, size: 13)
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
        txtField.textAlignment = .right
        text.subscribe(onNext: {[unowned self] value in
                    if value == nil{
                        self.layer.borderColor = UIColor.appMango.cgColor
                        self.layer.borderWidth = 1.5
                        
                        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseInOut], animations: {
                            self.alpha = 0.6
                        }, completion: { _ in
                            self.alpha = 1.0
                            
                        })
                    }else{
                        self.layer.borderWidth = 0
                        self.txtField.text = value
                        
                    }
            
        
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
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
