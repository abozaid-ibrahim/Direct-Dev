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

class VideoController: UIViewController {
    private var videoUrl: String
    var player: AVPlayer
    var autoPlay: Bool
    init(url: String, autoPlay: Bool = true) {
        self.videoUrl = url
        self.autoPlay = autoPlay
        self.player = AVPlayer(url: URL(string: url)!)
        super.init(nibName: "VideoController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.autoPlay {
            guard let url = URL(string: videoUrl) else {
                return
            }
            self.playVideo(url: url)
        }
    }

    func playVideo(url: URL) {
        let playervc = AVPlayerViewController()
        playervc.player = self.player
        self.addChild(playervc)
        self.view.addSubview(playervc.view)
        playervc.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9, execute: {[weak self] in
            self?.player.play()

        })
    }
}

