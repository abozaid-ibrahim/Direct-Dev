//
//  SwipeUpToDismiss.swift
//  Direct
//
//  Created by abuzeid on 5/10/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

import PanModal
import UIKit
import RxSwift
import RxCocoa
import RxGesture

protocol SwipeUpDismissable:UIViewController {
    var initialTouchPoint: CGPoint {get set}
    var defaultFrame:CGRect?{get}
    var disposeBag:DisposeBag{get}
    var dismessed: PublishSubject<Bool> {get set}
    func enableSwipeUpToDismiss()
    func swipeUpToDismiss(sender:UIPanGestureRecognizer,initialTouchPoint:inout CGPoint,defaultFrame:CGRect?)
    
}
extension SwipeUpDismissable{
    func enableSwipeUpToDismiss(){
        view.rx.panGesture().asObservable().subscribe({sender in
            self.swipeUpToDismiss(sender: sender.element!, initialTouchPoint: &self.initialTouchPoint, defaultFrame: self.defaultFrame)
        }).disposed(by: disposeBag)
        addBottomLine()
    }
    func addBottomLine(){
        let button = UIView()
        button.backgroundColor = .lightGray
        button.cornerRadiusV = 7
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 15).isActive = true
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
    }

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
