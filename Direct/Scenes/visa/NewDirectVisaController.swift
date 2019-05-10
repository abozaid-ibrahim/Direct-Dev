//
//  NewVisaViewController.swift
//  Direct
//
//  Created by abuzeid on 4/29/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import PanModal
import UIKit
import RxSwift
import RxCocoa
import RxGesture

class NewDirectVisaController: UIViewController,SwipeUpDismissable {
    let disposeBag = DisposeBag()
    var dismessed: PublishSubject<Bool> = PublishSubject()
    @IBOutlet var checkoutFooter: CheckoutFooter!
    @IBOutlet var countryField: SpinnerTextField!
    
    var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    var defaultFrame:CGRect?{
        didSet{
            self.view.frame = defaultFrame ?? CGRect.zero
        }
    }
    @IBOutlet weak var visaField: SpinnerTextField!
    @IBOutlet weak var passangersCountField: SpinnerTextField!
    @IBOutlet weak var relationsField: SpinnerTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        enableSwipeUpToDismiss()
        
        checkoutFooter.action = { [weak self] in
            try! AppNavigator().push(.paymentMethod)
        }
        
        setONClickViews()
        
    }
    
    private func setONClickViews(){
        countryField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
            self.presentPanModal(Destination.selectableSheet(data: "").controller() as! UIViewController & PanModalPresentable)
            }).disposed(by: disposeBag)
        
        passangersCountField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
            try! AppNavigator().presentModally(.passangersCount)
            }).disposed(by: disposeBag)
        
        dateField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
            try! AppNavigator().presentModally(.datePicker)
            }).disposed(by: disposeBag)
        
        visaField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
            try! AppNavigator().presentModally(.datePicker)
            }).disposed(by: disposeBag)
        relationsField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
            try! AppNavigator().presentModally(.datePicker)
            }).disposed(by: disposeBag)
        
        
    }
    
    
    
    @IBOutlet weak var dateField: SpinnerTextField!
    
    
}
