//
//  Toaster.swift
//  Direct
//
//  Created by abuzeid on 8/3/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

class TransientAlertViewController: AlertViewController {
    
    private weak var timer: Timer?
    private var countdown: Int = 5
    var msg: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        alertView.titleLabel.text = ""
        updateMessage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimer()
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.countdown -= 1
            self?.updateMessage()
        }
    }
    
    @objc func updateMessage() {
        guard countdown > 0 else {
            invalidateTimer()
            dismiss(animated: true, completion: nil)
            return
        }
        alertView.message.text = msg
    }
    
    func invalidateTimer() {
        timer?.invalidate()
    }
    
    deinit {
        invalidateTimer()
    }
    
    // MARK: - Pan Modal Presentable
    
    override var showDragIndicator: Bool {
        return false
    }
    
    override var anchorModalToLongForm: Bool {
        return true
    }
    
    override var backgroundAlpha: CGFloat {
        return 0.0
    }
    
    override var isUserInteractionEnabled: Bool {
        return false
    }
}
