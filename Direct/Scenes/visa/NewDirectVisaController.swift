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

protocol SwipeUpDismissable:UIViewController {
    var initialTouchPoint: CGPoint {get set}
    var defaultFrame:CGRect?{get}
    var dismessed: PublishSubject<Bool> {get set}
    func enableSwipeUpToDismiss()
func swipeUpToDismiss(sender:UIPanGestureRecognizer,initialTouchPoint:inout CGPoint,defaultFrame:CGRect?)
    
}
extension SwipeUpDismissable{
    func enableSwipeUpToDismiss(){
//        let gest = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerHandler(_:)))
//    view.addGestureRecognizer(gest)
        view.rx.panGesture().asObservable().subscribe({sender in
            self.swipeUpToDismiss(sender: sender.element!, initialTouchPoint: &self.initialTouchPoint, defaultFrame: self.defaultFrame)
        })
    }
}
class NewDirectVisaController: UIViewController,SwipeUpDismissable {
    private let disposeBag = DisposeBag()
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
extension SwipeUpDismissable{
    func swipeUpToDismiss(sender:UIPanGestureRecognizer,initialTouchPoint:inout CGPoint,defaultFrame:CGRect?){
        let touchPoint = sender.location(in: view?.window)
        if sender.state == UIGestureRecognizer.State.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizer.State.changed {
            if touchPoint.y - initialTouchPoint.y <= 0 {
                let newY = touchPoint.y - initialTouchPoint.y
                view.frame = CGRect(x: 0, y: newY, width: view.frame.size.width, height: view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
            if    initialTouchPoint.y - touchPoint.y > 100 {
                UIView.animate(withDuration: 0.3, animations: {
                    let tempY = self.view.bounds.height
                    self.view.frame = CGRect(x: 0, y: -tempY, width: self.view.frame.size.width, height: self.view.frame.size.height)
                    
                }, completion: { [weak self] _ in
                    guard let self = self else {return}
                    
                    self.dismessed.onNext(true)
                    self.removeFromParent()
                })
            } else {
                UIView.animate(withDuration: 0.3, animations: {[weak self] in
                    guard let self = self , let frame = defaultFrame else {return}
                    self.view.frame = frame
                })
            }
        }
        
    }
}
