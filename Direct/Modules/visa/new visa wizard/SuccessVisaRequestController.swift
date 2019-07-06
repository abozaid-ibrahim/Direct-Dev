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
    var trackNo: String?
    
    @IBOutlet private var videoPlayerContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupActionBar(.withX)
        self.requestNumberLbl.text = self.trackNo
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.addPlayer()
    }
    
    lazy var playerVC = UIStoryboard.main.controller(VideoController.self) as! VideoController
    private func addPlayer() {
        self.playerVC.videoUrl = self.thanksUrl!
        //        player.viewDidLoad()
        addChild(self.playerVC)
        self.videoPlayerContainer.addSubview(self.playerVC.view)
        self.playerVC.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        guard let url = URL(string: thanksUrl!) else {
            return
        }
        
//        self.player = Player()
////        self.player.playerDelegate = self
////        self.player.playbackDelegate = self
////        self.player.view.frame = self.view.bounds
//
//        self.addChild(self.player)
//        self.videoPlayerContainer.addSubview(self.player.view)
//        player.view.frame = videoPlayerContainer.bounds
////        self.player.view.snp.makeConstraints { make in
////            make.edges.equalToSuperview()
////        }
//        self.player.url = url
//        player.autoplay = true
//        self.player.didMove(toParent: self)
//        self.player.playFromBeginning()
    }
    
    @IBAction func dismissAction(_: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func followMyOrder(_: Any) {
        try! AppNavigator().push(.MyOrders(trackNo: trackNo))
    }
}
