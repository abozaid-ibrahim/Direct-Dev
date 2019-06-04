//
//  PassangersController.swift
//  Direct
//
//  Created by abuzeid on 5/4/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import UIKit

class PassangersController: UIViewController, ImagePicker {
    var currentImageID: Int = 0
    let familyImageID = 30
    let visaImageID = 23
    // MARK: IBuilder ====================================>>
    // Family
    @IBOutlet var firstNamePInfoLbl: FloatingTextField!
    @IBOutlet var familyNamePInfoLbl: FloatingTextField!
    @IBOutlet var statusPInfoLbl: FloatingTextField!
    @IBOutlet var husbundPInfoLbl: FloatingTextField!
    @IBOutlet var familyIDPInfoLbl: FloatingTextField!
    // MOTHER
    @IBOutlet var firstNameMotherLbl: FloatingTextField!
    @IBOutlet var familyNameMotherLbl: FloatingTextField!
    @IBOutlet var nationalityMotherLbl: FloatingTextField!
    // Questions
    @IBOutlet var previousVisaIdImageLbl: FloatingTextField!
    @IBOutlet var arrivalDateLbl: FloatingTextField!
    @IBOutlet var durationLbl: FloatingTextField!
    @IBOutlet var everHadVisaSegment: UISegmentedControl!
    @IBOutlet var traveledInLast10YrsSegment: UISegmentedControl!
    //===================================================<<
    var pickerId = 0
    internal let disposeBag = DisposeBag()
    var receivedImage = PublishSubject<(String?, UIImage?)>()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrivalDateLbl.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.showDatePickerDialog()
            }).disposed(by: disposeBag)
        
        familyIDPInfoLbl.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                self.showImagePicker(id: self.familyImageID)
            }.disposed(by: disposeBag)
       
        previousVisaIdImageLbl.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                self.showImagePicker(id: self.visaImageID)
            }.disposed(by: disposeBag)
        
        
        previousVisaIdImageLbl.rx.tapGesture().when(.recognized)
            .subscribe { _ in
                self.showImagePicker(id: self.visaImageID)
            }.disposed(by: disposeBag)
        
        receivedImage.filter { $0.0 != nil }.subscribe(onNext: { [unowned self] value in
            if self.currentImageID == self.familyImageID {
                self.params.familyIDCopy = value.1?.convertImageToBase64String()
                self.familyIDPInfoLbl.text = value.0
                
            } else if self.currentImageID == self.visaImageID {
                self.params.visaReqID = value.1?.convertImageToBase64String()
                self.previousVisaIdImageLbl.text = value.0
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
    
    func showDatePickerDialog() {
        let dest = Destination.datePicker
        let vc = dest.controller() as! DatePickerController
        vc.selectedDate.asObservable().subscribe { event in
            switch event.event {
            case .next(let value):
                self.arrivalDateLbl.text = value!.apiFormat
                self.params.dateOfArrival = value!.apiFormat
            default:
                break
            }
            
        }.disposed(by: disposeBag)
        try! AppNavigator().presentModally(vc)
    }
    
    func validateTextFields() {}
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
        params.everIssuedVisaBefore = "\(everHadVisaSegment.state == .selected ? 1 : 0 )"
        params.travelledBeforeHere = "\(traveledInLast10YrsSegment.state == .selected ? 1 : 0 )"
        
        // Others PDF
        //        params.personalPhotoCopy
        params.previousVisaCopy = previousVisaIdImageLbl.text
        params.lang = AppLanguage.langCode
        //        params.typeOfPreviousVisa = prev
        params.periodOfPreviousStay = durationLbl.text
    }
    
    var params = USRequestParams()
    private let network = ApiClientFacade()
    func submit() {
        fillParams()
        validateTextFields()
        Progress.show()
        network.applyToUSVisa(params: params)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] response in
              Progress.hide()
                
                try! AppNavigator().push(.successVisaReqScreen(response))
            }, onError: {e in
                Progress.hide()
            } , onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
}
