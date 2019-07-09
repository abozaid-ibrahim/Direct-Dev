//
//  AboutUsViewController.swift
//  Direct
//
//  Created by abuzeid on 5/17/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxOptional
import RxSwift
import UIKit

class AboutUsViewController: UIViewController {
    private let viewModel = AboutUsViewModel()
    @IBOutlet private var txtLbl: UILabel!
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []

        title = "من نحن"
        viewModel.aboutText
            .filterNil()
            .map { ($0.details ?? "").html2String }
            .asDriver(onErrorJustReturn: "")
            .drive(txtLbl.rx.text).disposed(by: disposeBag)
    }
}
