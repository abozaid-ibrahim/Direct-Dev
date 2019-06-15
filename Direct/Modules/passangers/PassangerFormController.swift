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
    private let familyImageID = 30
    private let passportImageID = 31
    private let visaImageID = 32
    private let last10YearsVisaImageID = 33
    private let personalPhotoID = 35
    // Inject FromOutSide
    var countryName: String!
    var countryId: String!
    var formType: String!
    var index: Int!
    var successIndex = PublishSubject<Int>()

    // MARK: IBuilder ====================================>>

    @IBOutlet private var personalInfoContainer: UIView!
    @IBOutlet private var personalInfoHeight: NSLayoutConstraint!
    @IBOutlet private var motherInfoContainer: UIView!
    @IBOutlet private var motherInfoHeight: NSLayoutConstraint!

    // Ever you had a vis
    @IBOutlet var everTraveledBeforeView: UIView!
    @IBOutlet var previousVisaLbl: UILabel!
    @IBOutlet var previousVisaImageField: FloatingTextField!
    @IBOutlet var everHadVisaSegment: UISegmentedControl!

    // countries
    @IBOutlet var relativeField: FloatingTextField!
    @IBOutlet private var previouslyTraveledCountriesView: UIView!
    @IBOutlet private var countriesContainerHeight: NSLayoutConstraint!
    @IBOutlet private var rejetionReasonField: FloatingTextField!
    @IBOutlet private var relativeInCountryLbl: UILabel!
    @IBOutlet private var relativeINCountrySegment: UISegmentedControl!
    @IBOutlet private var visaCancelationLbl: UILabel!
    @IBOutlet private var visaCancelationSegment: UISegmentedControl!
    @IBOutlet private var traveledHereBeforeHConstrain: NSLayoutConstraint!

    //===================================================<<
    internal let disposeBag = DisposeBag()
    var receivedImage = PublishSubject<(String?, UIImage?)>()
    let viewModel = PassangerFormViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        personalInfoSetup()
        motherSectionSetup()
        questionsSetup()
        addPreviousCountries()
        addEverTraveledView()
        setFonts()
        relativeSwitchChanged()
        cancelReasonSwitch()
        viewModel.getRelatives()
        onRecieveImageCallback()
    }

    private func motherSectionSetup() {
        switch formTypeValue {
        case .US:
            let motherView: MotherInfoView = MotherInfoView.loadNib()
            motherView.formType = formTypeValue
            motherView.params = params
            motherInfoContainer.addSubview(motherView)
            motherView.frame = motherInfoContainer.bounds
            motherView.contentHeight.bind(to: motherInfoHeight.rx.constant).disposed(by: disposeBag)
        default:
            print("hide this section")
            motherInfoHeight.constant = 0
            motherInfoContainer.isHidden = true
        }
    }

    private func setFonts() {
        visaCancelationSegment.appFont()
        relativeINCountrySegment.appFont()
        everHadVisaSegment.appFont()
    }

    let travels = UIStoryboard.visa.controller(PreviousTraveledCountriesController.self)
    private func addPreviousCountries() {
        guard let travelVC = travels as? PreviousTraveledCountriesController else { return }
        addChild(travelVC)
        previouslyTraveledCountriesView.addSubview(travelVC.view)
        travelVC.view.sameBoundsTo(parentView: previouslyTraveledCountriesView)
        travelVC.tableHeight.asDriver(onErrorJustReturn: travelVC.headerHeight).asObservable().bind(to: countriesContainerHeight.rx.constant).disposed(by: disposeBag)
    }

    let questionsVC = PassangersQuestionsStepVC()
    private func addEverTraveledView() {
        addChild(questionsVC)
        questionsVC.countryText = countryString
        everTraveledBeforeView.addSubview(questionsVC.view)
        questionsVC.view.frame = everTraveledBeforeView.bounds
        questionsVC.selectedDuration.filter { $0?.id != nil }.subscribe(onNext: { [unowned self] value in
            self.params.periodOfPreviousStay = value?.id ?? ""
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        questionsVC.contentHeight
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
        let personalInfoView: PersonalInfoView = PersonalInfoView.loadNib()
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
//            if self.currentImageID == self.familyImageID {
//                self.params.familyIDCopy = value.1?.convertImageToBase64String()
//                self.familyIDPInfoLbl.text = value.0
//
//            } else if self.currentImageID == self.visaImageID {
//                self.params.visaReqID = value.1?.convertImageToBase64String()
//                self.previousVisaImageField.text = value.0
//            } else if self.currentImageID == self.passportImageID {
//                self.params.passportCopy = value.1?.convertImageToBase64String()
//                self.passportImageField.text = value.0
//            } else if self.currentImageID == self.personalPhotoID {
//                self.params.personalPhotoCopy = value.1?.convertImageToBase64String()
//                self.personalPhotoField.text = value.0
//            }
//
//        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }

    private func questionsSetup() {
        // ever you travedled
        previousVisaLbl.text = "هل سبق وحصلت على تأشيرة " + countryString + Str.before
        relativeInCountryLbl.text = "هل لديك اى اقارب فى " + countryString + "؟"
        visaCancelationLbl.text = "هل تم رفض دخولك أو الغاء تأشيرتك الى " + countryString + Str.before
        previousVisaImageField.neverShowKeypad()
        previousVisaImageField.rx.tapGesture().when(.recognized)
            .subscribe { _ in
//                self.showImagePicker(id: self.visaImageID)
            }.disposed(by: disposeBag)

        relativeField.neverShowKeypad()
        relativeField.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                self.showRelationsSpinner()
            }.disposed(by: disposeBag)
        viewModel.selectedRelation.bind(to: relativeField.rx.text).disposed(by: disposeBag)
    }

    @IBAction func cancelReasonChanged(_: UISegmentedControl) {
        cancelReasonSwitch()
    }

    private func cancelReasonSwitch() {
        if visaCancelationSegment.selectedSegmentIndex == Segment.no {
            rejetionReasonField.isHidden = true
        } else {
            rejetionReasonField.isHidden = false
        }
    }

    @IBAction func hasRelativeDidChange(_: UISegmentedControl) {
        relativeSwitchChanged()
    }

    private func relativeSwitchChanged() {
        if relativeINCountrySegment.selectedSegmentIndex == Segment.no {
            relativeField.isHidden = true
        } else {
            relativeField.isHidden = false
        }
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
        /// Personal Info
//        params.firstName = firstNamePInfoLbl.text
//        params.familyName = familyNamePInfoLbl.text
//        params.martialStatus = statusPInfoLbl.text
//        params.familyIDCopy = familyIDPInfoLbl.text
//        params.husbandOrWifeTravelWithYou = husbundPInfoLbl.text
//        /// Mother
        // Questions
        params.everIssuedVisaBefore = "\(visaCancelationSegment.selectedSegmentIndex)"
        params.travelledBeforeHere = questionsVC.travelledBeforeHere.stringValue

        // Others PDF
        params.lang = AppLanguage.langCode

        params.travelledBeforeHere = prevTravelsJson
        params.have_driver_license = questionsVC.haveLicense
        params.any_relatives_here = relativeINCountrySegment.selectedSegmentIndex
        params.visa_cancelled_before = visaCancelationSegment.selectedSegmentIndex
        //
    }

    var prevTravelsJson: String {
        return InputJsonBuilder().buildPassangers((travels as! PreviousTraveledCountriesController).items)
    }

    var params = USRequestParams()
    private let network = ApiClientFacade()
    func submit() {
        fillParams()
       
        Progress.show()
        guard let cnt = CountriesIDs(rawValue: countryId.intValue) else {
            return
        }
        sendDataToServer(network.applyToVisa(path: cnt.endPointPath, params: params))
    }

    func sendDataToServer(_ api: Observable<USVvisaRequestJSONResponse>) {
        api.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] _ in
                Progress.hide()
                self.successIndex.onNext(self.index ?? 0)
            }, onError: { _ in
                Progress.hide()
            }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
}
