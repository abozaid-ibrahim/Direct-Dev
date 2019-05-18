//
//  UploadField.swift
//  Direct
//
//  Created by abuzeid on 5/18/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import UIKit
@IBDesignable
class UploadField: FloatingTextField {
    let bag = DisposeBag()
    let icon = UIImageView()
    @IBInspectable
    var image: UIImage? {
        didSet {
            self.icon.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI(image: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createUI(image: nil)
    }
    
    init(_ image: UIImage) {
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 40)))
        createUI(image: image)
    }
    
    func createUI(image: UIImage?) {
        guard let img = image else {
            return
        }
        icon.image = img
        addSubview(icon)
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: icon.centerYAnchor).isActive = true
        trailingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 10).isActive = true
        widthAnchor.constraint(equalToConstant: 20).isActive = true
        heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
