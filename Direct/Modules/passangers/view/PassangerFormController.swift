//
//  PassangerFormController.swift
//  Direct
//
//  Created by abuzeid on 6/4/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import UIKit

class PassangerFormController: UIViewController {
    var currentImageID: Int = 0
    private let visaImageID = 32
    private let last10YearsVisaImageID = 33
    var countryName: String!
    var countryId: String!
    var formType: String!
    var index: Int!
    var successIndex = PublishSubject<Int>()
    var visaType: String?

    // MARK: IBuilder ====================================>>

    // containers
    @IBOutlet private var personalInfoContainer: UIView!
    @IBOutlet private var personalInfoHeight: NSLayoutConstraint!
    @IBOutlet private var motherInfoContainer: UIView!
    @IBOutlet private var motherInfoHeight: NSLayoutConstraint!
    @IBOutlet private var visaQuestionsContainer: UIView!
    @IBOutlet private var visaQuestionsHeight: NSLayoutConstraint!

    // Ever you had a vis
    @IBOutlet var everTraveledBeforeContainer: UIView!
    @IBOutlet private var previouslyTraveledCountriesView: UIView!
    @IBOutlet private var countriesContainerHeight: NSLayoutConstraint!
    @IBOutlet private var traveledHereBeforeHConstrain: NSLayoutConstraint!

    //===================================================<<
    let motherView: MotherInfoView = MotherInfoView.loadNib()
    let travels = UIStoryboard.visa.controller(PreviousTraveledCountriesController.self)
    let everTraveldView = EverTraveledHereBeforeView()
    let personalInfoView: PersonalInfoView = PersonalInfoView.loadNib()
    let visaQuestionsView: VisaQuestionsView = VisaQuestionsView.loadNib()

    internal let disposeBag = DisposeBag()
    var receivedImage = PublishSubject<(String?, UIImage?)>()
    private var params = USRequestParams()
    private let network = ApiClientFacade()
    override func viewDidLoad() {
        super.viewDidLoad()
        addPersonalInfoSction()
        addMotherInfoSection()
        addQuestionsSection()
        addPreviousCountries()
        addEverTraveledView()
    }

    private func addPersonalInfoSction() {
        if visaType ?? "" == "2" {
            personalInfoView.visaType = .study
        } else {
            personalInfoView.visaType = .torrerist
        }
        personalInfoView.params = params
        personalInfoView.formType = formTypeValue
        personalInfoContainer.addSubview(personalInfoView)
        personalInfoView.frame = personalInfoContainer.bounds
        personalInfoView.contentHeight.bind(to: personalInfoHeight.rx.constant).disposed(by: disposeBag)
    }
    private func addMotherInfoSection() {
        if hasMotherView {
            motherView.formType = formTypeValue
            motherView.params = params
            motherInfoContainer.addSubview(motherView)
            motherView.frame = motherInfoContainer.bounds
            motherView.contentHeight.debug().bind(to: motherInfoHeight.rx.constant).disposed(by: disposeBag)
        } else {
            print("hide this section")
            motherInfoHeight.constant = 0
            motherInfoContainer.isHidden = true
        }
    }

    private func addQuestionsSection() {
        print(formTypeValue)
        func add() {
            visaQuestionsView.params = params
            visaQuestionsContainer.addSubview(visaQuestionsView)
            visaQuestionsView.frame = visaQuestionsContainer.bounds
            visaQuestionsView.formType = formTypeValue
            visaQuestionsView.contentHeight.bind(to: visaQuestionsHeight.rx.constant).disposed(by: disposeBag)
        }
        switch formTypeValue {
        case .TR ,.IN :
            visaQuestionsContainer.isHidden = true
        case .SGN:
            add()
            visaQuestionsView.countryName = Str.schengen
        case .CN, .US, .GB, .IE, .JP:
            add()
            visaQuestionsView.countryName = countryString
        }
    }
    private func addEverTraveledView() {
        switch formTypeValue {
        case .SGN,.CN, .TR, .IE , .IN, .JP:
            everTraveledBeforeContainer.isHidden = true
        case  .US, .GB:
            addChild(everTraveldView)
            everTraveldView.countryText = countryString
            everTraveledBeforeContainer.addSubview(everTraveldView.view)
            everTraveldView.view.frame = everTraveledBeforeContainer.bounds
            everTraveldView.selectedDuration.filter { $0?.id != nil }.subscribe(onNext: { [unowned self] value in
                self.params.periodOfPreviousStay = value?.id ?? ""
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
            everTraveldView.contentHeight.bind(to: traveledHereBeforeHConstrain.rx.constant).disposed(by: disposeBag)
        }
    }

    private func addPreviousCountries() {
        guard let travelVC = travels as? PreviousTraveledCountriesController else { return }
        switch formTypeValue {
        case .SGN, .TR, .IE, .JP:
            previouslyTraveledCountriesView.isHidden = true
        case .CN, .US, .GB, .IN:
            addChild(travelVC)
            previouslyTraveledCountriesView.addSubview(travelVC.view)
            travelVC.view.sameBoundsTo(parentView: previouslyTraveledCountriesView)
            travelVC.tableHeight.asDriver(onErrorJustReturn: travelVC.headerHeight).asObservable().bind(to: countriesContainerHeight.rx.constant).disposed(by: disposeBag)
        }
    }
    var formTypeValue: CountriesIDs {
        return CountriesIDs(formType: formType)
    }


    private var countryString: String {
        return countryName ?? ""
    }

  

    func getPreviousVisaTypes() {
        network.getPreviousVisaType().retry(2).subscribe(onNext: { [unowned self] value in
            if let types = value.previousVisaType {
                self.showOptions(types)
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }

    @IBAction func submitData(_: Any) {
        submit()
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.editedImage] as? UIImage
        let fileUrl = info[.imageURL] as? URL
        receivedImage.onNext((fileUrl?.lastPathComponent, image?.apiSize()))

        picker.dismiss(animated: true, completion: nil)
    }

    func getEverTraveldParams() {
        if !everTraveledBeforeContainer.isHidden{
            params.travelledBeforeHere = everTraveldView.travelledBeforeHere.stringValue
            // Others PDF
            params.lang = AppLanguage.langCode
            params.travelledBeforeHere = prevTravelsJson
            params.have_driver_license = everTraveldView.haveLicense
        }
       
    }

    var prevTravelsJson: String {
        let countries = (travels as! PreviousTraveledCountriesController).items
        if countries.isEmpty{
            return ""
        }
        return InputJsonBuilder().buildPassangers(countries)
    }

    var hasMotherView: Bool {
        return (formTypeValue == .US) || (formTypeValue == .IN) || (formTypeValue == CountriesIDs.GB) || (formTypeValue == CountriesIDs.TR)
    }

    func submit() {
        getEverTraveldParams()
        guard personalInfoView.isInputsValid() else {
            return
        }
        if hasMotherView {
            guard motherView.isInputsValid() else {
                return
            }
        }
        if !visaQuestionsContainer.isHidden{
            guard visaQuestionsView.isInputsValid() else{
                return
            }
        }
        Progress.show()
        guard let cnt = CountriesIDs(rawValue: countryId.intValue) else {
            return
        }
        sendDataToServer(network.applyToVisa(path: cnt.endPointPath, params: params))
    }

    func sendDataToServer(_ api: Observable<USVvisaRequestJSONResponse>) {
        api.subscribe(onNext: { [unowned self] _ in
            Progress.hide()
            self.successIndex.onNext(self.index ?? 0)
        }, onError: { _ in
            Progress.hide()
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
}
