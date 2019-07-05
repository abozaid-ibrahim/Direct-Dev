//
//  SuccessVisaRequestController.swift
//  Direct
//
//  Created by abuzeid on 5/2/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class SuccessVisaRequestController: UIViewController, StyledActionBar {
    @IBOutlet private var requestNumberLbl: UILabel!
    internal let disposeBag = DisposeBag()
    
//    depenencies
    var thanksUrl: String?
    var orderId: String?
    
    @IBOutlet private var videoPlayerContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupActionBar(.withX)
        self.requestNumberLbl.text = self.orderId
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
         self.addPlayer()
    }
    private func addPlayer() {
        let player = VideoController(url: self.thanksUrl!)
        addChild(player)
        self.videoPlayerContainer.addSubview(player.view)
        player.view.snp.makeConstraints{make in
            make.edges.equalToSuperview()
        }
    }
    
    @IBAction func dismissAction(_: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func followMyOrder(_: Any) {
        try! AppNavigator().push(.MyOrders)
    }
}

class SuccessViewModel {}
