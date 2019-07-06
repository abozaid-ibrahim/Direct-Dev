//
//  VideoController.swift
//  Direct
//
//  Created by abuzeid on 7/5/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import AVFoundation
import AVKit
import UIKit
//
// class VideoController: UIViewController {
//    private var videoUrl: String
//    var player: AVPlayer
//    var autoPlay: Bool
//    override func loadView() {
//        view = UIView()
//    }
//
//    init(url: String, autoPlay: Bool = true) {
//        self.videoUrl = url
//        self.autoPlay = autoPlay
//        self.player = AVPlayer(url: URL(string: url)!)
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        if autoPlay {
//            guard let url = URL(string: videoUrl) else {
//                return
//            }
//            playVideo(url: url)
//        }
//    }
//
//    let playervc = AVPlayerViewController()
//    func playVideo(url: URL) {
//        let player = AVPlayer(url: URL(string: videoUrl)!)
//
//        playervc.player = player
//
//        present(playervc, animated: true) {
//            self.playervc.player?.play()
//        }
//    }
// }

class VideoController: AVPlayerViewController, AVPlayerViewControllerDelegate {
     var videoUrl: String!
    var autoPlay: Bool = true
//    init(url: String, autoPlay: Bool = true) {
//        self.videoUrl = url
//        self.autoPlay = autoPlay
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        initPlayer(url: url)
        
        super.viewDidAppear(animated)
//        play(url: url)
    }
    var url: URL {
        return URL(string: videoUrl)!
    }

    
    func initPlayer(url: URL) {
        player = AVPlayer(url: url)
    }
    
    func play(url: URL) {
        let playerItem = AVPlayerItem(url: url)
        player?.replaceCurrentItem(with: playerItem)
        player?.play()
    }
    
}
