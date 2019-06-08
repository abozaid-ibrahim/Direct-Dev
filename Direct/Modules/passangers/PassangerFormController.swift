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
    var currentImageID: Int = 0
    let familyImageID = 30
    let visaImageID = 23
    let last10YearsVisaImageID = 20
    var countryName: String?

    var countryId: String?
    var index:Int?
    var successIndex = PublishSubject<Int>()

    // MARK: IBuilder ====================================>>
    // Family
    @IBOutlet var firstNamePInfoLbl: FloatingTextField!
    @IBOutlet var familyNamePInfoLbl: FloatingTextField!
    @IBOutlet var statusPInfoLbl: FloatingTextField!
    @IBOutlet var isHusbandWillTravelView: UIView!
    
    @IBOutlet var husbundPInfoLbl: FloatingTextField!
    @IBOutlet var familyIDPInfoLbl: FloatingTextField!
    // MOTHER
    @IBOutlet var firstNameMotherLbl: FloatingTextField!
    @IBOutlet var familyNameMotherLbl: FloatingTextField!
    @IBOutlet var nationalityMotherLbl: FloatingTextField!
    //Ever you had a vis
    @IBOutlet weak var previousVisaLbl: UILabel!
    @IBOutlet weak var previousVisaImageField: FloatingTextField!
    @IBOutlet var everHadVisaSegment: UISegmentedControl! {
        didSet {
            everHadVisaSegment.appFont()
        }
    }
    
    
    
    // last 10 years
    @IBOutlet weak var didYouTraveledLast10YearLbl: UILabel!
    @IBOutlet weak var last10VisaField: FloatingTextField!
    @IBOutlet var traveledInLast10YrsSegment: UISegmentedControl! {
        didSet {
            traveledInLast10YrsSegment.appFont()
        }
    }
    //countries
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
                    self?.husbundPInfoLbl.text = agreed.rawValue
                })
            }.disposed(by: disposeBag)
    }
    private var countryString:String{
        return countryName ?? ""
    }
    private func questionsSetup() {
       // ever you travedled
        previousVisaLbl.text = " من قبل؟" + countryString + "هل سبق وحصلت على تأشيرة"
        
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
            }else if self.currentImageID == self.last10YearsVisaImageID{
                self.params.previousVisaCopy = value.1?.convertImageToBase64String()
                self.last10VisaField.text = value.0
            }
            
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        last10YearsSection()
    }
    private func last10YearsSection(){
        
        didYouTraveledLast10YearLbl.text = "في العشر سنوات الاخيرة ؟" + countryString + "هل سافرت الى "
        
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
    
   
    
    func isValidateTextFields() -> Bool {
        if !isValidatePersonalSectionTextFields() {
            return false
        }
        if !isValidateFamilySectionTextFields() {
            return false
        }
        
        return true
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
        //        params.personalPhotoCopy
        params.lang = AppLanguage.langCode
        //        params.typeOfPreviousVisa = prev
//        params.periodOfPreviousStay = durationLbl.text
        
        //
        
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
        guard let id = countryId else {
            return
        }
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
            .subscribe(onNext: { [unowned self] response in
                Progress.hide()
                self.successIndex.onNext(self.index ?? 0)
            }, onError: { _ in
                Progress.hide()
            }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
}
