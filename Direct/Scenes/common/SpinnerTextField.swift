//
//  SpinnerTextField.swift
//  Direct
//
//  Created by abuzeid on 4/29/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
@IBDesignable
class SpinnerTextField: UIView {
    let txtField  = UITextField()
    private let leftLogo  = UIImageView()
    private let rightLogo  = UIImageView()

    @IBInspectable var leftImage:UIImage?{
        didSet{
            leftLogo.image = leftImage
        }
    }
    @IBInspectable var rightImage:UIImage?{
        didSet{
            rightLogo.image = rightImage
        }
    }
    @IBInspectable var hint:String?{
        didSet{
            txtField.placeholder = hint ?? ""
        }
    }
    typealias Action = ()->()
    var action: Action?
    func setOnclick(ac: @escaping Action){
        self.action = ac
        let tap = UITapGestureRecognizer(target: self, action: #selector(clicked(sender: )))
        self.addGestureRecognizer(tap)
        
    }
    @objc private func clicked(sender:Any){
        self.action?()
    }
   private func createUI(){
        let stack  = UIStackView()
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing  = 10
        leftLogo.translatesAutoresizingMaskIntoConstraints  = false
        leftLogo.widthAnchor.constraint(equalToConstant: 25).isActive = true
        leftLogo.contentMode = .scaleAspectFit
        
        rightLogo.translatesAutoresizingMaskIntoConstraints  = false
        rightLogo.widthAnchor.constraint(equalToConstant: 25).isActive = true
        rightLogo.contentMode = .scaleAspectFit
        
        stack.addArrangedSubview(leftLogo)
        stack.addArrangedSubview(txtField)
        stack.addArrangedSubview(rightLogo)
        
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
