//
//  AlertController.swift
//  Direct
//
//  Created by abuzeid on 8/3/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import PanModal
import UIKit

class AlertViewController: UIViewController, PanModalPresentable {
    
    private let alertViewHeight: CGFloat = 68
    
    let alertView: AlertView = {
        let alertView = AlertView()
        alertView.layer.cornerRadius = 10
        return alertView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.addSubview(alertView)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        alertView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        alertView.heightAnchor.constraint(equalToConstant: alertViewHeight).isActive = true
    }
    
    // MARK: - PanModalPresentable
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(alertViewHeight)
    }
    
    var longFormHeight: PanModalHeight {
        return shortFormHeight
    }
    
    var backgroundAlpha: CGFloat {
        return 0.1
    }
    
    var shouldRoundTopCorners: Bool {
        return false
    }
    
    var showDragIndicator: Bool {
        return true
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
    
    var isUserInteractionEnabled: Bool {
        return true
    }
}

import UIKit

class AlertView: UIView {
    
    // MARK: - Views
    
    private let colors = [#colorLiteral(red: 0.7215686275, green: 0.9098039216, blue: 0.5607843137, alpha: 1), #colorLiteral(red: 0.7176470588, green: 0.8784313725, blue: 0.9882352941, alpha: 1), #colorLiteral(red: 0.9725490196, green: 0.937254902, blue: 0.4666666667, alpha: 1), #colorLiteral(red: 0.9490196078, green: 0.7568627451, blue: 0.9803921569, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.8823529412, blue: 0.6980392157, alpha: 1)]
    
    private lazy var icon: UIView = {
        let icon = UIView()
        icon.backgroundColor = colors.randomElement()
        icon.layer.cornerRadius = 6.0
        icon.isHidden = true
        return icon
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Incoming Message"
        label.font = UIFont.appRegularFontWith(size: 14)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    let message: UILabel = {
        let label = UILabel()
        label.text = "This is an example alert..."
        label.font = UIFont.appRegularFontWith(size: 12)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    private lazy var alertStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, message])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4.0
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupView() {
        backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.5019607843, blue: 0.01568627451, alpha: 1)
        layoutIcon()
        layoutStackView()
    }
    
    private func layoutIcon() {
        addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14).isActive = true
        icon.topAnchor.constraint(equalTo: topAnchor, constant: 14).isActive = true
        icon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14).isActive = true
        icon.widthAnchor.constraint(equalTo: icon.heightAnchor).isActive = true
    }
    
    private func layoutStackView() {
        addSubview(alertStackView)
        alertStackView.translatesAutoresizingMaskIntoConstraints = false
        alertStackView.topAnchor.constraint(equalTo: icon.topAnchor).isActive = true
        alertStackView.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 10).isActive = true
        alertStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14).isActive = true
        alertStackView.bottomAnchor.constraint(equalTo: icon.bottomAnchor).isActive = true
    }
}
