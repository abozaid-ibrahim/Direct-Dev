//
//  PassangerFormViewModel.swift
//  Direct
//
//  Created by abuzeid on 6/4/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

// Validation
extension PassangerFormController {
    func isValidateTextFields() -> Bool {
        if !isValidatePersonalSectionTextFields() {
            return false
        }
        if !isValidateFamilySectionTextFields() {
            return false
        }

        return true
    }

    func isValidateFamilySectionTextFields() -> Bool {
        if params.mothersFirstName.isValidText {
            firstNameMotherLbl.setError.onNext(false)
        } else {
            firstNameMotherLbl.setError.onNext(true)
            return false
        }
        if params.mothersFamilyName.isValidText {
            familyNameMotherLbl.setError.onNext(false)
        } else {
            familyNamePInfoLbl.setError.onNext(true)
            return false
        }

        return true
    }

    func isValidatePersonalSectionTextFields() -> Bool {
        if params.firstName.isValidText {
            firstNamePInfoLbl.setError.onNext(false)
        } else {
            firstNamePInfoLbl.setError.onNext(true)
            return false
        }
        if params.familyName.isValidText {
            familyNamePInfoLbl.setError.onNext(false)
        } else {
            familyNamePInfoLbl.setError.onNext(true)
            return false
        }
        if params.martialStatus.isValidText {
            statusPInfoLbl.setError.onNext(false)
        } else {
            statusPInfoLbl.setError.onNext(true)
            return false
        }
        if !isHusbandWillTravelView.isHidden {
            if husbundPInfoLbl.text.isValidText {
                husbundPInfoLbl.setError.onNext(false)
            } else {
                husbundPInfoLbl.setError.onNext(true)
                return false
            }
        }
        if !isTravelWithFamilyView.isHidden {
            if params.familyIDCopy.isValidText {
                familyIDPInfoLbl.setError.onNext(false)
            } else {
                familyIDPInfoLbl.setError.onNext(true)
                return false
            }
        }
        if params.passportCopy.isValidText {
            passportImageField.setError.onNext(false)
        } else {
            passportImageField.setError.onNext(true)
            return false
        }
        if params.personalPhotoCopy.isValidText {
            personalPhotoField.setError.onNext(false)
        } else {
            personalPhotoField.setError.onNext(true)
            return false
        }
        return true
    }
}
