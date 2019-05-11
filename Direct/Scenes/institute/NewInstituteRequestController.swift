//
//  NewInstituteRequestController.swift
//  Direct
//
//  Created by abuzeid on 5/2/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import RxSwift
import PanModal
import RxGesture

class NewInstituteRequestController: UIViewController,SwipeUpDismissable {
         let disposeBag = DisposeBag()
        var dismessed: PublishSubject<Bool> = PublishSubject()
        var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
        var defaultFrame:CGRect?{
            didSet{
                self.view.frame = defaultFrame ?? CGRect.zero
            }
        }
        
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var travelDateField: SpinnerTextField!
    @IBOutlet weak var studyPeriod: SpinnerTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        enableSwipeUpToDismiss()
        setupFields()
    }
    private func setupFields(){
        travelDateField.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                 try! AppNavigator().presentModally(.datePicker)
            }).disposed(by: disposeBag)
        
        studyPeriod.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                try! AppNavigator().presentModally(.datePicker)
            }).disposed(by: disposeBag)
        
    }
    @IBAction func searchAction(_ sender: Any) {
        try? AppNavigator().push(.institutesList)
    }
    
}
