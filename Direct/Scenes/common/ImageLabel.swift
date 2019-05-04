//
//  ImageLabel.swift
//  Direct
//
//  Created by abuzeid on 5/3/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
@IBDesignable
class ImageLabel: UIView {
    
    let txtLabel = UILabel()
    let hintImage = UIImageView()
    
    @IBInspectable var logoImage:UIImage?{
        didSet{
            hintImage.image = logoImage
        }
    }
    
    @IBInspectable var txt:String?{
        didSet{
            txtLabel.text = txt
        }
    }
    
    private func createUI(){
        let stack  = UIStackView()
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.spacing  = 10
        hintImage.translatesAutoresizingMaskIntoConstraints  = false
        hintImage.widthAnchor.constraint(equalToConstant: 25).isActive = true
        hintImage.contentMode = .scaleAspectFit
        
        stack.addArrangedSubview(hintImage)
        stack.addArrangedSubview(txtLabel)
        
        self.addSubview(stack)
        stack.sameBoundsTo(parentView: self,l: 10,tr: 10)
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        createUI()
        self.backgroundColor = UIColor.appOffWhite
        self.cornerRadiusV = 8
    }
}
