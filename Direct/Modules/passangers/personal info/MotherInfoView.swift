//
//  MotherInfoView.swift
//  Direct
//
//  Created by abuzeid on 6/15/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import UIKit
class MotherInfoView: UIView, PassangerInputsSection {
    // MOTHER
    @IBOutlet var firstNameMotherField: FloatingTextField!
    @IBOutlet var familyNameMotherField: FloatingTextField!
    @IBOutlet var nationalityMotherField: FloatingTextField!
    var params: USRequestParams?
    var formType: CountriesIDs? {
        didSet {
//            applyFormRules()
        }
    }
    
    internal let disposeBag = DisposeBag()
    var contentHeight = BehaviorSubject<CGFloat>(value: 145)
    
    func isInputsValid() -> Bool {
        params?.mothersFirstName = firstNameMotherField.text
        params?.mothersFamilyName = familyNameMotherField.text
        params?.nationality = nationalityMotherField.text
        return firstNameMotherField.hasText && familyNameMotherField.hasText && nationalityMotherField.hasText
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewSetup()
    }
    

   
    
    private func viewSetup() {}
}
