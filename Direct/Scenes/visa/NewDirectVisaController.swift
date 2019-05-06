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

protocol SwipeUpDismissable {
    var dismessed: PublishSubject<Bool> {get set}
    
}
class NewDirectVisaController: UIViewController,SwipeUpDismissable {
    
    var dismessed: PublishSubject<Bool> = PublishSubject()
    
    
 
    
    @IBOutlet var checkoutFooter: CheckoutFooter!
    @IBOutlet var countryField: SpinnerTextField!
    
    private var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
     var defaultFrame:CGRect?{
        didSet{
           self.view.frame = defaultFrame ?? CGRect.zero
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        countryField.setOnclick {
            self.presentPanModal(Destination.selectableSheet(data: "").controller() as! UIViewController & PanModalPresentable)
        }
        checkoutFooter.action = { [weak self] in
            self?.present(PaymentViewController(), animated: true, completion: nil)
        }
    
    
    ///
        
        let gest = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerHandler(_:)))
    
        view.addGestureRecognizer(gest)
    }





@objc private func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
    let touchPoint = sender.location(in: view?.window)
    if sender.state == UIGestureRecognizer.State.began {
        initialTouchPoint = touchPoint
    } else if sender.state == UIGestureRecognizer.State.changed {
        if touchPoint.y - initialTouchPoint.y <= 0 {
            let newY = touchPoint.y - initialTouchPoint.y
            view.frame = CGRect(x: 0, y: newY, width: view.frame.size.width, height: view.frame.size.height)
        }
    } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
        print(touchPoint.y,initialTouchPoint.y)
        if    initialTouchPoint.y - touchPoint.y > 100 {
            UIView.animate(withDuration: 0.3, animations: {
                let tempY = self.view.bounds.height
                self.view.frame = CGRect(x: 0, y: -tempY, width: self.view.frame.size.width, height: self.view.frame.size.height)
                
            }, completion: { [weak self] _ in
             guard let self = self else {return}
              self.removeFromParent()
                self.dismessed.onNext(true)
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {[weak self] in
                guard let self = self , let frame = self.defaultFrame else {return}
                self.view.frame = frame
            })
        }
    }
}
}
