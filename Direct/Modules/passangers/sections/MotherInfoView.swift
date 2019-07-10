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
    
    @IBOutlet weak var titleLbl: UILabel!
    var params: VisaRequirementsParams?
    var formType: CountriesIDs? {
        didSet {
            applyFormRules()
        }
    }
    
    internal let disposeBag = DisposeBag()
    var contentHeight = BehaviorSubject<CGFloat>(value: 130)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewSetup()
        contentHeight.onNext(neededHeight)
        titleLbl.font = .appBoldFontWith(size: 15)
        titleLbl.textColor = UIColor.appBlack
    }
    
    func isInputsValid() -> Bool {
        if firstNameMotherField.text.isValidText {
            firstNameMotherField.setError.onNext(false)
        } else {
            firstNameMotherField.setError.onNext(true)
            return false
        }
        if familyNameMotherField.text.isValidText {
            familyNameMotherField.setError.onNext(false)
        } else {
            familyNameMotherField.setError.onNext(true)
            return false
        }
        
        params?.mothersFirstName = firstNameMotherField.text
        params?.mothersFamilyName = familyNameMotherField.text
        
        //validate id
        if formType! != CountriesIDs.TR{
            if nationalityMotherField.text.isValidText {
                nationalityMotherField.setError.onNext(false)
            } else {
                nationalityMotherField.setError.onNext(true)
                return false
            }
            params?.nationality = nationalityMotherField.text
            
        }
        return true
    }
    func applyFormRules(){
        if formType! == .TR{
            nationalityMotherField.isHidden = true
        }
        
        
        contentHeight.onNext(neededHeight)
    }

    var neededHeight: CGFloat {
        var basic = 55
        let unit = 55
        basic += firstNameMotherField.isHidden ? 0 : unit
        basic += nationalityMotherField.isHidden ? 0 : unit
        return CGFloat(basic)
    }
    
    private func viewSetup() {
        
    }
}
