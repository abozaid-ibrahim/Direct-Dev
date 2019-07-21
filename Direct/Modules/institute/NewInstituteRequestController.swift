//
//  NewInstituteRequestController.swift
//  Direct
//
//  Created by abuzeid on 5/2/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import PanModal
import RxGesture
import RxSwift
import UIKit

class NewInstituteRequestController: UIViewController, SwipeUpDismissable {
    let disposeBag = DisposeBag()
    var dismessed: PublishSubject<Bool> = PublishSubject()
    var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    var defaultFrame: CGRect? {
        didSet {
            view.frame = defaultFrame ?? CGRect.zero
        }
    }
    var scrollView: UIScrollView?
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var travelDateField: SpinnerTextField!
    @IBOutlet var studyPeriod: SpinnerTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        enableSwipeUpToDismiss()
        setupFields()
    }

    private func setupFields() {
        travelDateField.rx.tapGesture().when(.recognized)
            .subscribe({ _ in
                try! AppNavigator().presentModally(.datePicker(title:nil))
            }).disposed(by: disposeBag)

        studyPeriod.rx.tapGesture().when(.recognized)
            .subscribe({ _ in
                try! AppNavigator().presentModally(.datePicker(title:nil))
            }).disposed(by: disposeBag)
    }

    @IBAction func searchAction(_: Any) {
        try? AppNavigator().push(.institutesList)
    }
}
