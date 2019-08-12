//
//  SuccessVisaRequestController.swift
//  Direct
//
//  Created by abuzeid on 5/2/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import MediaPlayer
import RxCocoa
import RxSwift
import UIKit
import YouTubePlayer

class SuccessVisaRequestController: UIViewController, StyledActionBar {
    @IBOutlet private var requestNumberLbl: UILabel!
    internal let disposeBag = DisposeBag()
    
//    depenencies
    var thanksUrl: String?
    var trackNo: String?
    
    @IBOutlet private var videoPlayerContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestNumberLbl.text = self.trackNo
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupActionBar(.withX)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.playFromYoutube()
    }
    
    @IBAction func dismissAction(_: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func followMyOrder(_: Any) {
        try! AppNavigator().push(.MyOrders(trackNo: self.trackNo))
    }
    
    private var videoPlayer: YouTubePlayerView?
    
    private func playFromYoutube() {
        self.videoPlayer = YouTubePlayerView(frame: self.videoPlayerContainer.bounds)
        guard let myVideoURL = URL(string: self.thanksUrl ?? "") else {return}
        self.videoPlayerContainer.addSubview(self.videoPlayer!)
        self.videoPlayer?.frame = self.videoPlayerContainer.bounds
        self.videoPlayer?.loadVideoURL(myVideoURL)
        self.videoPlayer?.play()
    }
}
