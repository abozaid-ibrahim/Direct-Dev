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
    var screenData = PublishSubject<[NewVisaServices]>()
    var bioOptions: [BioOption] = []
    var relativesList: [USRelative] = []
    var selectedDate = PublishSubject<Date?>()
    var showProgress = PublishSubject<Bool>()
    private var network: ApiClientFacade?
    var selectedCountry: NewVisaServices?
    var selectedCountryName = PublishSubject<String?>()
    private var priceNotes: [Price_notes]? {
        didSet {
            guard let value = priceNotes else { return }
            let notes = value.filter { $0.note_type != nil }
            let rightNotes = notes.filter { $0.note_type ?? -1 == 1 }.map { $0.text ?? "" }
            let dontNotes = notes.filter { $0.note_type ?? -1 == 0 }.map { $0.text ?? "" }
            let rightText = rightNotes.joined(separator: "\n-")
            let badText = dontNotes.joined(separator: "\n-")
            doNotesText.onNext(rightText)
            dontNotesText.onNext(badText)
        }
    }

    var doNotesText = PublishSubject<String?>()
    var dontNotesText = PublishSubject<String?>()
    var passangersCount = PublishSubject<PassangerCount?>()
    var selectedVisaType = PublishSubject<String?>()
    var selectedBio = PublishSubject<String?>()
    var selectedRelation = PublishSubject<String?>()
    var totalCost = BehaviorSubject<String>(value: "0".priced)
    var embassyLocations: [DTEmbassyLocation]?
    var turkeyCountryId: String {
        return APIConstants.TurkeyID
    }

    init(network: ApiClientFacade? = ApiClientFacade()) {
        self.network = network
    }

    func viewDidLoad() {
        guard let network = network else {
            return
        }
        showProgress.onNext(true)

        // get countries
        let countries = network.getCountries()
        countries.subscribe(onNext: { [weak self] countries in
            self?.screenData.onNext(countries.newVisaServices ?? [])
        }, onError: { [weak self] err in
            self?.screenData.onError(err)
            self?.showProgress.onNext(false)
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        // get biou
        let bios = network.getBiometricChoices()
        bios.subscribe(onNext: { [weak self] bios in
            self?.bioOptions.append(contentsOf: bios.bioOption)
        }, onError: { [weak self] _ in
            self?.showProgress.onNext(false)
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)

        // get relatives
        let rel = network.getVisaRelations().retry(2)
        rel.subscribe(onNext: { [weak self] bios in

            self?.relativesList.append(contentsOf: bios.usRelatives ?? [])
        }, onError: { [weak self] _ in
            self?.showProgress.onNext(false)
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)

        Observable.zip(
            countries, bios, rel,
            resultSelector: { _, _, _ in
                self.showProgress.onNext(false)
            }
        ).observeOn(MainScheduler.instance)
            .subscribe()
            .disposed(by: disposeBag)
    }

    var visaRequestData = VisaRequestParams()
    var hasBioLocation: Bool = true
    func validateForPassangersCount(_ hasBioLocation: Bool) -> Bool {
        if visaRequestData.country_id == nil {
            selectedCountryName.onNext(nil)
            return false
        } else if visaRequestData.visatype == nil {
            selectedVisaType.onNext(nil)
            return false
        } else if visaRequestData.biometry_loc_id == nil, visaRequestData.country_id != turkeyCountryId, hasBioLocation {
            selectedBio.onNext(nil)
            return false
        } else if visaRequestData.travel_date == nil {
            selectedDate.onNext(nil)
            return false
        }
        return true
    }

    func validateInputs() -> Bool {
        if !validateForPassangersCount(hasBioLocation) {
            return false
        } else if unValidPassCount {
            passangersCount.onNext(nil)
            return false
        } else if visaRequestData.relation_with_travelers == nil, passCount > 1 {
            selectedRelation.onNext(nil)
            return false
        }
        return true
    }

    var unValidPassCount: Bool {
        return visaRequestData.no_of_child == nil && visaRequestData.no_of_adult == nil && visaRequestData.country_id != turkeyCountryId
    }

    var passCount: Int {
        let adults = (Int(visaRequestData.no_of_adult ?? "0") ?? 0)
        let childs = (Int(visaRequestData.no_of_child ?? "0") ?? 0)
        return childs + adults
    }

    func submitVisaRequest() {
        guard validateInputs() else {
            return
        }

        showProgress.onNext(true)
        network?.sendVisaRequest(params: visaRequestData).subscribe(onNext: { [unowned self] _ in
            try! AppNavigator().push(.visaRequirement(self.visaRequestData)
            )
        }, onError: { _ in
            self.showProgress.onNext(false)
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }

    func showVisaTypes() {
        guard let data = selectedCountry?.visatypes else {
            selectedCountryName.onNext(nil)
            return
        }
        let str = data.filter { $0.visaTypeName != nil }.map { $0.visaTypeName ?? "" }
        let dest = Destination.selectableSheet(data: str, titleText: "نوع التأشيرة", style: .textCenter)
        let vc = dest.controller() as! SelectableTableSheet
        vc.selectedItem.asObservable().subscribe { event in
            switch event.event {
            case let .next(value):

                let itms = data.filter { $0.visaTypeName ?? "" == value }
                if let visa = itms.first {
                    self.visaRequestData.visatype = visa.visaTypeId
                    self.visaRequestData.visatypeText = visa.visaTypeName
                }
                self.selectedVisaType.onNext(value)
            default:
                break
            }

        }.disposed(by: disposeBag)
        try! AppNavigator().presentModally(vc)
    }

    func showBiometricSpinner() {
        guard let locations = embassyLocations else { return }
        let cities = locations.map { $0.cityName }
        let dest = Destination.selectableSheet(data: cities, titleText: "مكان البصمة", style: .textCenter)
        let vc = dest.controller() as! SelectableTableSheet
        vc.selectedItem.asObservable().subscribe { event in
            switch event.event {
            case let .next(value):
                let locations = locations.filter { $0.cityName == value }

                if let cityObj = locations.first {
                    self.visaRequestData.biometry_loc_id = cityObj.cityID
                    self.visaRequestData.biometry_loc = cityObj.cityName
                    self.selectedBio.onNext(value)
                    if let notes = cityObj.price_notes {
                        self.priceNotes = notes
                    }
                }
            default:
                break
            }

        }.disposed(by: disposeBag)
        try! AppNavigator().presentModally(vc)
    }

    func showDatePickerDialog() {
        let dest = Destination.datePicker(title: nil)
        let vc = dest.controller() as! DatePickerController
        vc.selectedDate.asObservable().subscribe { event in
            switch event.event {
            case let .next(value):
                self.visaRequestData.travel_date = value!.apiFormat
                self.selectedDate.onNext(value)
            default:
                break
            }

        }.disposed(by: disposeBag)
        try! AppNavigator().presentModally(vc)
    }

    var hideBioLocation = PublishSubject<Bool>()
    var countriesController: SearchViewController?
    private func initCountriesController() {
        if countriesController == nil {
            countriesController = Destination.searchCountries.controller() as! SearchViewController

            countriesController?.selectedItem.subscribe { event in
                switch event.event {
                case let .next(value):
                    self.selectedCountry = value
                    print("i> id \(value.country_id) form type: \(value.form_type!)")
                    self.visaRequestData.form_type = value.form_type
                    self.visaRequestData.country_id = value.country_id!
                    self.visaRequestData.countryName = value.countryName
                    self.selectedCountryName.onNext(value.countryName)
                    // RESET dep values
                    self.selectedBio.onNext("")
                    self.selectedVisaType.onNext("")
                    self.embassyLocations = nil
                    self.hideBioLocation.onNext(true)

                    self.priceNotes = []
                    if let notes = value.price_notes {
                        self.priceNotes = notes
                    }

                    let cities = self.network?.getCities(country: value.country_id!).share()
                    cities?.subscribe(onNext: { [weak self] cities in
                        print("xx\(cities.dtEmbassyLocations.isNilOrEmpty)")
                        self?.embassyLocations = cities.dtEmbassyLocations
                        self?.hideBioLocation.onNext(cities.dtEmbassyLocations.isNilOrEmpty)
                        self?.hasBioLocation = cities.dtEmbassyLocations.isNilOrEmpty
                    }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)

                default:
                    break
                }

            }.disposed(by: disposeBag)
        }
    }

    func showCountriesSpinner() {
        initCountriesController()
        try! AppNavigator().presentModally(countriesController!)
    }

    func showPasangersCountSpinner() {
        guard validateForPassangersCount(hasBioLocation) else {
            return
        }
        let vc = Destination.passangersCount.controller() as! PassangersCountController

        vc.info = VisaPriceParams(cid: visaRequestData.country_id, cityid: visaRequestData.biometry_loc_id ?? "0", no_of_adult: visaRequestData.no_of_adult ?? "0", no_of_child: visaRequestData.no_of_child ?? "0", no_of_passport: visaRequestData.no_of_passport ?? "0", promo_code: 0.stringValue, visatype: visaRequestData.visatype)

        vc.result.asObservable().subscribe { event in
            switch event.event {
            case let .next(value):
                self.passangersCount.onNext(value)
                self.visaRequestData.no_of_adult = "\(value.0)"
                self.visaRequestData.no_of_child = "\(value.1)"
//                if (self.selectedCountry?.country_id ?? "-1") == APIConstants.TurkeyID {
                self.visaRequestData.no_of_passport = self.passCount.stringValue
//                }
                self.totalCost.onNext(value.2.priced)

                self.visaRequestData.totalCost = value.2

            default:
                break
            }

        }.disposed(by: disposeBag)
        try! AppNavigator().presentModally(vc)
    }

    func showRelationsSpinner() {
        let bios = relativesList.map { $0.name ?? "" }
        let dest = Destination.selectableSheet(data: bios, titleText: "العلاقة بين المسافرين", style: .textCenter)
        let vc = dest.controller() as! SelectableTableSheet
        vc.selectedItem.asObservable().subscribe { event in
            switch event.event {
            case let .next(value):
                let bio = self.relativesList.filter { $0.name == value }
                if let bioObj = bio.first {
                    self.visaRequestData.relation_with_travelers = bioObj.id
                    self.visaRequestData.relation_with_travelersText = bioObj.name
                }

                self.selectedRelation.onNext(value)

            default:
                break
            }

        }.disposed(by: disposeBag)
        try! AppNavigator().presentModally(vc)
    }
}

enum InputsError: Error {
    case missingInput
}
