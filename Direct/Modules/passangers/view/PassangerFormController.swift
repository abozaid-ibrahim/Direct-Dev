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
    // ImagePicker
    var currentImageID: Int = 0
    private let visaImageID = 32
    private let last10YearsVisaImageID = 33
    // Inject FromOutSide
    var countryName: String!
    var countryId: String!
    var formType: String!
    var index: Int!
    var successIndex = PublishSubject<Int>()

    // MARK: IBuilder ====================================>>

    // containers
    @IBOutlet private var personalInfoContainer: UIView!
    @IBOutlet private var personalInfoHeight: NSLayoutConstraint!
    @IBOutlet private var motherInfoContainer: UIView!
    @IBOutlet private var motherInfoHeight: NSLayoutConstraint!
    @IBOutlet private var visaQuestionsContainer: UIView!
    @IBOutlet private var visaQuestionsHeight: NSLayoutConstraint!

    // Ever you had a vis
    @IBOutlet var everTraveledBeforeView: UIView!

    // countries
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
    override func viewDidLoad() {
        super.viewDidLoad()
        personalInfoSetup()
        motherSectionSetup()
        questionsSetup()
        addPreviousCountries()
        addEverTraveledView()
    }

    private func motherSectionSetup() {
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

    private func addPreviousCountries() {
        guard let travelVC = travels as? PreviousTraveledCountriesController else { return }
        addChild(travelVC)
        previouslyTraveledCountriesView.addSubview(travelVC.view)
        travelVC.view.sameBoundsTo(parentView: previouslyTraveledCountriesView)
        travelVC.tableHeight.asDriver(onErrorJustReturn: travelVC.headerHeight).asObservable().bind(to: countriesContainerHeight.rx.constant).disposed(by: disposeBag)
    }

    private func addEverTraveledView() {
        addChild(everTraveldView)
        everTraveldView.countryText = countryString
        everTraveledBeforeView.addSubview(everTraveldView.view)
        everTraveldView.view.frame = everTraveledBeforeView.bounds
        everTraveldView.selectedDuration.filter { $0?.id != nil }.subscribe(onNext: { [unowned self] value in
            self.params.periodOfPreviousStay = value?.id ?? ""
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        everTraveldView.contentHeight
            .asDriver(onErrorJustReturn: 0)
            .debug()
            .drive(onNext: { value in
                self.animateConstrain(value: value)
            }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }

    private func animateConstrain(value: CGFloat) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            self.traveledHereBeforeHConstrain.constant = value
        }, completion: nil)
    }

    var formTypeValue: CountriesIDs {
        return CountriesIDs(formType: formType)
    }

    private func personalInfoSetup() {
        personalInfoView.formType = formTypeValue
        personalInfoView.params = params
        personalInfoContainer.addSubview(personalInfoView)
        personalInfoView.frame = personalInfoContainer.bounds
        personalInfoView.contentHeight.bind(to: personalInfoHeight.rx.constant).disposed(by: disposeBag)
    }

    private var countryString: String {
        return countryName ?? ""
    }

    private func onRecieveImageCallback() {
//        receivedImage.filter { $0.0 != nil }.subscribe(onNext: { [unowned self] value in
//            if self.currentImageID == self.visaImageID {
//                self.params.visaReqID = value.1?.convertImageToBase64String()
//                self.previousVisaImageField.text = value.0
//            }
//
//        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }

    private func questionsSetup() {
        visaQuestionsView.formType = formTypeValue
        visaQuestionsView.params = params
        visaQuestionsContainer.addSubview(visaQuestionsView)
        visaQuestionsView.frame = visaQuestionsContainer.bounds
        visaQuestionsView.contentHeight.bind(to: visaQuestionsHeight.rx.constant).disposed(by: disposeBag)
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
        receivedImage.onNext((fileUrl?.lastPathComponent, image))

        picker.dismiss(animated: true, completion: nil)
    }

    func fillParams() {
        params.travelledBeforeHere = everTraveldView.travelledBeforeHere.stringValue

        // Others PDF
        params.lang = AppLanguage.langCode

        params.travelledBeforeHere = prevTravelsJson
        params.have_driver_license = everTraveldView.haveLicense
    }

    var prevTravelsJson: String {
        return InputJsonBuilder().buildPassangers((travels as! PreviousTraveledCountriesController).items)
    }

    var params = USRequestParams()
    private let network = ApiClientFacade()
    var hasMotherView: Bool {
        return (formTypeValue == .US) || (formTypeValue == .IN) || (formTypeValue == CountriesIDs.GB) || (formTypeValue == CountriesIDs.TR)
    }

    func submit() {
        fillParams()
        guard personalInfoView.isInputsValid() else {
            return
        }
        if hasMotherView {
            guard motherView.isInputsValid() else {
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
        api.observeOn(MainScheduler.instance).subscribeOn(SerialDispatchQueueScheduler(qos: .background)).subscribe(onNext: { [unowned self] _ in
            Progress.hide()
            self.successIndex.onNext(self.index ?? 0)
        }, onError: { _ in
            Progress.hide()
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
}
