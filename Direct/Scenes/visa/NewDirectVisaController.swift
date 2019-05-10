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
    @IBOutlet weak var passangersCountField: SpinnerTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        enableSwipeUpToDismiss()
        // Do any additional setup after loading the view.
        countryField.setOnclick {
            self.presentPanModal(Destination.selectableSheet(data: "").controller() as! UIViewController & PanModalPresentable)
        }
        checkoutFooter.action = { [weak self] in
            self?.present(PaymentViewController(), animated: true, completion: nil)
        }
        
        
        
       
        
        
        passangersCountField.rx.tapGesture().subscribe({[weak self] _ in
            guard let self = self else {return}
            try! AppNavigator().presentModally(.passangersCount)
        }).disposed(by: disposeBag)
    }
    
    
    
    
    
//    @objc private func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
//        swipeUpToDismiss(sender: sender, initialTouchPoint: &initialTouchPoint, defaultFrame: defaultFrame)
//    }
}
