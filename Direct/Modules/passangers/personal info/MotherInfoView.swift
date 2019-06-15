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
            applyFormRules()
        }
    }
    
    internal let disposeBag = DisposeBag()
    var contentHeight = BehaviorSubject<CGFloat>(value: 145)
    
    func isInputsValid() -> Bool {
        params?.mothersFirstName = firstNameMotherField.text
        params?.mothersFamilyName = familyNameMotherField.text
        params?.nationality = nationalityMotherField.text
        let name =  firstNameMotherField.hasText && familyNameMotherField.hasText
        
        //validate id
        var id = true
        if formType! != CountriesIDs.TR{
            id = nationalityMotherField.hasText
        }
        return name && id
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
    func applyFormRules(){
        if formType! == .TR{
            nationalityMotherField.isHidden = true
        }
        
        
        contentHeight.onNext(neededHeight)
    }

    var neededHeight: CGFloat {
        var basic = 65
        let unit = 55
        basic += firstNameMotherField.isHidden ? 0 : unit
        basic += familyNameMotherField.isHidden ? 0 : unit
        basic += nationalityMotherField.isHidden ? 0 : unit
        return CGFloat(basic)
    }
    
    private func viewSetup() {
        
    }
}
