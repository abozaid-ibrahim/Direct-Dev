//
//   Dialog.swift
//  Direct
//
//  Created by abuzeid on 6/4/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxSwift
import SwifterSwift
import UIKit

class DialogBuilder {
    func buildAgreemnetDialog(callback: @escaping (AgreementValues) -> Void) -> UIAlertController {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.applyAppStyle()
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
        return alert
    }

    func buildMatrialState(callback: @escaping (MartialState) -> Void) -> UIAlertController {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.applyAppStyle()
        let action = UIAlertAction(title: MartialState.married.string, style: .default, handler: { _ in
            callback(MartialState.married)
        })
        let singleAction = UIAlertAction(title: MartialState.single.string, style: .default, handler: { _ in
            callback(MartialState.single)
        })

        alert.addAction(action)
        alert.addAction(singleAction)
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        alert.addAction(cancel)
        return alert
    }

    func showDatePickerDialog(_ disposeBag: DisposeBag, date: @escaping (String) -> Void) {
        let dest = Destination.datePicker(title: nil)
        let vc = dest.controller() as! DatePickerController
        vc.selectedDate.asObservable().subscribe { event in
            switch event.event {
            case let .next(value):
                date(value!.string())
            default:
                break
            }

        }.disposed(by: disposeBag)
        try! AppNavigator().presentModally(vc)
    }

    func buildRelationsSpinner(_ disposeBag: DisposeBag, _ relativesList: [Relative], selected: @escaping (Relative) -> Void) {
        let bios = relativesList.map { $0.name ?? "" }
        let dest = Destination.selectableSheet(data: bios, titleText: "relativity".localized, style: .textCenter)
        let vc = dest.controller() as! SelectableTableSheet
        vc.selectedItem.asObservable().subscribe { event in
            switch event.event {
            case let .next(value):

                let bio = relativesList.filter { $0.name == value }
                if let bioObj = bio.first {
                    selected(bioObj)
                }

            default:
                break
            }

        }.disposed(by: disposeBag)
        try! AppNavigator().presentModally(vc)
    }
}

extension PassangerFormController {
    func showOptions(_ values: [PreviousVisaType]) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.applyAppStyle()
        for type in values {
            let action = UIAlertAction(title: type.name, style: .default, handler: { [weak self] _ in
                guard let `self` = self else { return }
                //              self.previousVisaIdImageLbl
            })
            alert.addAction(action)
        }

        present(alert, animated: true, completion: nil)
    }
}

extension UIAlertController {
    func applyAppStyle() {
        self.setTint(color: .appMango)
//        self.setTitle(font: .appRegularFontWith(size: 14), color: UIColor.appMango)

    }
}
