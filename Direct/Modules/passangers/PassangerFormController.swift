//
//  PassangerFormController.swift
//  Direct
//
//  Created by abuzeid on 6/4/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

import RxSwift
import UIKit

class PassangerFormController: UIViewController, ImagePicker {
    // MARK: ImagePicker
    
    var currentImageID: Int = 0
    private let familyImageID = 30
    private let visaImageID = 23
    private let last10YearsVisaImageID = 20
    
    // MARK: Inject FromOutSide
    
    var countryName: String!
    var countryId: String!
    var index: Int!
    
    // MARK: update parent
    
    var successIndex = PublishSubject<Int>()
    
    // MARK: IBuilder ====================================>>
    
    // Family
    @IBOutlet var firstNamePInfoLbl: FloatingTextField!
    @IBOutlet var familyNamePInfoLbl: FloatingTextField!
    @IBOutlet var statusPInfoLbl: FloatingTextField!
    @IBOutlet var isHusbandWillTravelView: UIView!
    
    @IBOutlet var husbundPInfoLbl: FloatingTextField!
    @IBOutlet var familyIDPInfoLbl: FloatingTextField!
    
    // MARK: MOTHER
    
    @IBOutlet var firstNameMotherLbl: FloatingTextField!
    @IBOutlet var familyNameMotherLbl: FloatingTextField!
    @IBOutlet var nationalityMotherLbl: FloatingTextField!
    
    // MARK: Ever you had a vis
    
    @IBOutlet var previousVisaLbl: UILabel!
    @IBOutlet var previousVisaImageField: FloatingTextField!
    @IBOutlet var everHadVisaSegment: UISegmentedControl! {
        didSet {
            everHadVisaSegment.appFont()
        }
    }
    
    // MARK: last 10 years
    
    @IBOutlet var didYouTraveledLast10YearLbl: UILabel!
    @IBOutlet var last10VisaField: FloatingTextField!
    @IBOutlet var traveledInLast10YrsSegment: UISegmentedControl! {
        didSet {
            traveledInLast10YrsSegment.appFont()
        }
    }
    
    // MARK: countries
    
    @IBOutlet private var previouslyTraveledCountriesView: UIView!
    @IBOutlet var countriesContainerHeight: NSLayoutConstraint!
    
    //===================================================<<
    internal let disposeBag = DisposeBag()
    var receivedImage = PublishSubject<(String?, UIImage?)>()
    override func viewDidLoad() {
        super.viewDidLoad()
        pInfoSetup()
        questionsSetup()
        addPreviousCountries()
    }
    
    let travels = UIStoryboard.visa.instantiateViewController(withIdentifier: "PreviousTraveledCountriesController") as! PreviousTraveledCountriesController
    
    private func addPreviousCountries() {
        addChild(travels)
        previouslyTraveledCountriesView.addSubview(travels.view)
        travels.view.sameBoundsTo(parentView: previouslyTraveledCountriesView)
        travels.tableHeight.asDriver(onErrorJustReturn: travels.headerHeight).asObservable().bind(to: countriesContainerHeight.rx.constant).disposed(by: disposeBag)
    }
    
    private func pInfoSetup() {
        statusPInfoLbl.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                self.showMatrialState()
            }.disposed(by: disposeBag)
        
        familyIDPInfoLbl.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                self.showImagePicker(id: self.familyImageID)
            }.disposed(by: disposeBag)
        
        husbundPInfoLbl.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                self.showAgreemnetDialog(callback: { [weak self] agreed in
                    self?.params.husbandOrWifeTravelWithYou = agreed.apiValue.stringValue
                    self?.husbundPInfoLbl.text = agreed.string
                })
            }.disposed(by: disposeBag)
    }
    
    private var countryString: String {
        return countryName ?? ""
    }
    
    private func questionsSetup() {
        // ever you travedled
        previousVisaLbl.text = "هل سبق وحصلت على تأشيرة " + countryString + " من قبل؟"
        
        previousVisaImageField.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                self.showImagePicker(id: self.visaImageID)
            }.disposed(by: disposeBag)
        
        receivedImage.filter { $0.0 != nil }.subscribe(onNext: { [unowned self] value in
            if self.currentImageID == self.familyImageID {
                self.params.familyIDCopy = value.1?.convertImageToBase64String()
                self.familyIDPInfoLbl.text = value.0
                
            } else if self.currentImageID == self.visaImageID {
                self.params.visaReqID = value.1?.convertImageToBase64String()
                self.previousVisaImageField.text = value.0
            } else if self.currentImageID == self.last10YearsVisaImageID {
                self.params.previousVisaCopy = value.1?.convertImageToBase64String()
                self.last10VisaField.text = value.0
            }
            
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        last10YearsSection()
    }
    
    private func last10YearsSection() {
        didYouTraveledLast10YearLbl.text = "هل سافرت الى " + countryString + " في العشر سنوات الاخيرة ؟"
        
        last10VisaField.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                self.showImagePicker(id: self.last10YearsVisaImageID)
            }.disposed(by: disposeBag)
    }
    
    func getPreviousVisaTypes() {
        network.getPreviousVisaType().retry(2).subscribe(onNext: { [unowned self] value in
            if let types = value.previousVisaType {
                self.showOptions(types)
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    @IBAction func submitData(_ sender: Any) {
        submit()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.editedImage] as? UIImage
        let fileUrl = info[.imageURL] as? URL
        
        receivedImage.onNext((fileUrl?.lastPathComponent, image))
        // image is our desired image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func fillParams() {
        /// Personal Info
        params.firstName = firstNamePInfoLbl.text
        params.familyName = familyNamePInfoLbl.text
        params.martialStatus = statusPInfoLbl.text
        params.familyIDCopy = familyIDPInfoLbl.text
        params.husbandOrWifeTravelWithYou = husbundPInfoLbl.text
        /// Mother
        params.mothersFirstName = firstNameMotherLbl.text
        params.mothersFamilyName = familyNameMotherLbl.text
        params.nationality = nationalityMotherLbl.text
        // Questions
        params.everIssuedVisaBefore = "\(everHadVisaSegment.state == .selected ? 1 : 0)"
        params.travelledBeforeHere = "\(traveledInLast10YrsSegment.state == .selected ? 1 : 0)"
        
        // Others PDF
        params.lang = AppLanguage.langCode
        
        params.travelledBeforeHere = prevTravelsJson
    }
    
    var prevTravelsJson: String {
        return InputJsonBuilder().buildPassangers(travels.items)
    }
    
    var params = USRequestParams()
    private let network = ApiClientFacade()
    func submit() {
        fillParams()
        guard isValidateTextFields() else {
            return
        }
        let id = countryId!
        Progress.show()
        
        if id == APIConstants.USID {
            sendDataToServer(network.applyToUSVisa(params: params))
        } else if id == APIConstants.UKID {
            sendDataToServer(network.applyToUKVisa(params: params))
        } else {
            sendDataToServer(network.applyToUSVisa(params: params))
        }
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
