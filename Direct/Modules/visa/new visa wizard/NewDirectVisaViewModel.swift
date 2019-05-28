//
//  NewDirectVisaViewModel.swift
//  Direct
//
//  Created by abuzeid on 5/26/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxOptional
import RxSwift

class NewDirectVisaViewModel {
    var disposeBag = DisposeBag()
    var screenData = PublishSubject<[NewVisaService]>()
    var bioOptions: [BioOption] = []
    var relativesList: [Relative] = []
    var selectedDate = PublishSubject<Date?>()

    private var network: ApiClientFacade?
    var selectedCountry: NewVisaService?
    var selectedCountryName = PublishSubject<String?>()
    var passangersCount = PublishSubject<PassangerCount>()

    var selectedVisaType = PublishSubject<String?>()
    var selectedBio = PublishSubject<String?>()
    var selectedRelation = PublishSubject<String?>()

    init(network: ApiClientFacade? = ApiClientFacade()) {
        self.network = network
    }

    func viewDidLoad() {
        // get countries
        network?.getCountries().subscribe(onNext: { [weak self] countries in
            self?.screenData.onNext(countries)
        }, onError: { [weak self] err in
            self?.screenData.onError(err)
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        // get biou
        network?.getBiometricChoices().subscribe(onNext: { [weak self] bios in
            self?.bioOptions.append(contentsOf: bios.bioOption)
        }, onError: { [weak self] _ in
//                self?.bioOptions.onError(err)
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)

        // get relatives
        network?.getRelationList().subscribe(onNext: { [weak self] bios in
            self?.relativesList.append(contentsOf: bios.relatives)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }

    func validate(msg: String) {}

    func showVisaTypes() {
        guard let data = selectedCountry?.visatypes else {
            validate(msg: "اختر الدولة اولاً")
            return
        }
        let str = data.map { "\($0.visaTypeName)" }

        let dest = Destination.selectableSheet(data: str, titleText: "نوع التأشيرة", style: .textCenter)
        let vc = dest.controller() as! SelectableTableSheet
        vc.selectedItem.asObservable().subscribe { event in
            switch event.event {
            case .next(let value):
                self.selectedVisaType.onNext(value)
            default:
                break
            }

        }.disposed(by: disposeBag)
        try! AppNavigator().presentModally(vc)
    }

    func showBiometricSpinner() {
        let bios = bioOptions.map { $0.name }
        let dest = Destination.selectableSheet(data: bios, titleText: "مكان البصمة", style: .textCenter)
        let vc = dest.controller() as! SelectableTableSheet
        vc.selectedItem.asObservable().subscribe { event in
            switch event.event {
            case .next(let value):
                let bio = self.bioOptions.filter { $0.name == value }
                if let bioObj = bio.first {
                    self.selectedBio.onNext(value)
                }
            default:
                break
            }

        }.disposed(by: disposeBag)
        try! AppNavigator().presentModally(vc)
    }
    func showDatePickerDialog() {
    
        let dest = Destination.datePicker
        let vc = dest.controller() as! DatePickerController
        vc.selectedDate.asObservable().subscribe { event in
            switch event.event {
            case .next(let value):
                    self.selectedDate.onNext(value)
            default:
                break
            }
            
            }.disposed(by: disposeBag)
        try! AppNavigator().presentModally(vc)
    }
   private let countriesController = Destination.searchCountries.controller() as! SearchViewController

    func showCountriesSpinner() {

        countriesController.selectedItem.asObservable().subscribe { event in
            switch event.event {
            case .next(let value):
                self.selectedCountry = value
                self.selectedCountryName.onNext(value.countryName)

            default:
                break
            }

        }.disposed(by: disposeBag)
        try! AppNavigator().presentModally(countriesController)
    }
    func showPasangersCountSpinner() {
        var vc  = Destination.passangersCount.controller() as! PassangersCountController
        
        vc.result.asObservable().subscribe { event in
            switch event.event {
            case .next(let value):
                self.passangersCount.onNext(value)
                
            default:
                break
            }
            
            }.disposed(by: disposeBag)
        try! AppNavigator().presentModally(vc)
    }


    func showRelationsSpinner() {
        let bios = relativesList.map { $0.name }
        let dest = Destination.selectableSheet(data: bios, titleText: "العلاقة بين المسافرين", style: .textCenter)
        let vc = dest.controller() as! SelectableTableSheet
        vc.selectedItem.asObservable().subscribe { event in
            switch event.event {
            case .next(let value):
                let bio = self.relativesList.filter { $0.name == value }
                if let bioObj = bio.first {}
                self.selectedRelation.onNext(value)

            default:
                break
            }

        }.disposed(by: disposeBag)
        try! AppNavigator().presentModally(vc)
    }
}
