//
//  Passagners + Dialog.swift
//  Direct
//
//  Created by abuzeid on 6/4/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import UIKit

extension PassangerFormController {
    func showMatrialState() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.setTint(color: .appMango)
        let action = UIAlertAction(title: MartialState.married.string, style: .default, handler: { [weak self] _ in
            guard let `self` = self else { return }
            self.params.martialStatus = MartialState.married.apiValue.stringValue
            self.isHusbandWillTravelView.isHidden = false
            self.statusPInfoLbl.text = MartialState.married.string
            
        })
        let singleAction = UIAlertAction(title: MartialState.single.string, style: .default, handler: { [weak self] _ in
            guard let `self` = self else { return }
            self.params.martialStatus = MartialState.single.apiValue.stringValue
            self.isHusbandWillTravelView.isHidden = true
             self.statusPInfoLbl.text = MartialState.single.string
        })
      
        alert.addAction(action)
        alert.addAction(singleAction)
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func showAgreemnetDialog(callback: @escaping (AgreementValues) -> ()) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.setTint(color: .appMango)
        let noAction = UIAlertAction(title: AgreementValues.no.string, style: .default, handler: { _ in
            callback(AgreementValues.no)
            
        })
        let yesAction = UIAlertAction(title: AgreementValues.yes.string, style: .default, handler: { [weak self] _ in
            callback(AgreementValues.yes)
            
        })
        alert.addAction(noAction)
        alert.addAction(yesAction)
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func showOptions(_ values: [PreviousVisaType]) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.setTint(color: .appMango)
        for type in values {
            let action = UIAlertAction(title: type.name, style: .default, handler: { [weak self] _ in
                guard let `self` = self else { return }
                //              self.previousVisaIdImageLbl
            })
            alert.addAction(action)
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    func showDatePickerDialog() {
        let dest = Destination.datePicker(title:nil)
        let vc = dest.controller() as! DatePickerController
        vc.selectedDate.asObservable().subscribe { event in
            switch event.event {
            case .next(let value):
                self.params.dateOfArrival = value!.apiFormat
            default:
                break
            }
            
            }.disposed(by: disposeBag)
        try! AppNavigator().presentModally(vc)
    }
}
