//
//  FloatingTextField.swift
//  Direct
//
//  Created by abuzeid on 5/7/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import SkyFloatingLabelTextField
import UIKit

class FloatingTextField: SkyFloatingLabelTextField {
    var setError = PublishSubject<Bool>()
    private let disposeBag = DisposeBag()
    override init(frame: CGRect) {
        super.init(frame: frame)
        CommonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        CommonInit()
    }

    func CommonInit() {
        selectedLineColor = .lightGray
        selectedTitleColor = .lightGray
        cornerRadiusV = 8
        borderWidthV = 1
        borderColorV = UIColor.appVeryLightGray
        backgroundColor = UIColor.appVeryLightGray
        titleFont = UIFont.appRegularFontWith(size: 10)
        titleLabel.font = UIFont.appRegularFontWith(size: 10)
        placeholderFont = UIFont.appRegularFontWith(size: 10)
        errorColor = UIColor.appMango

        font = UIFont.appRegularFontWith(size: 14)

        setError.subscribe(onNext: { [unowned self] value in
            if value {
                self.layer.borderColor = UIColor.appMango.cgColor
                self.layer.borderWidth = 1.5
                self.errorMessage = self.placeholder
                UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseInOut], animations: {
                    self.alpha = 0.6
                }, completion: { _ in
                    self.alpha = 1.0

                })
            } else {
                self.layer.borderWidth = 0
                self.errorMessage = nil
            }

        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }

    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
