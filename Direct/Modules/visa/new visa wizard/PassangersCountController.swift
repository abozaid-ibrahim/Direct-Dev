//
//  PassangersCountController.swift
//  Direct
//
//  Created by abuzeid on 5/9/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import PanModal
import RxSwift
import UIKit
typealias Price = Double
typealias PassangerCount = (Int, Int, Price)

class PassangersCountController: UIViewController, PanModalPresentable {
    var panScrollable: UIScrollView?
    var shortFormHeight: PanModalHeight = .contentHeight(350)
    private let disposeBag = DisposeBag()
    
    // MARK: IBuilder ====================================>>
    
    @IBOutlet var childCountLbl: UILabel!
    @IBOutlet var adultCountLbl: UILabel!
    @IBOutlet var childTotalLbl: UILabel!
    @IBOutlet var adultTotalLbl: UILabel!
    @IBOutlet private var countLbl: UILabel!
    //===================================================<<
    private let network = ApiClientFacade()
    var info: VisaPriceParams?
    private var totolCost: Double = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var childCount: Int {
        get {
            return Int(childCountLbl.text!)!
        }
        set {
            childCountLbl.text = "\(newValue)"
            setTotalFooterCount(men: menCount, child: newValue)
        }
    }
    
    var menCount: Int {
        get {
            return Int(adultCountLbl.text!)!
        }
        set {
            adultCountLbl.text = "\(newValue)"
            setTotalFooterCount(men: newValue, child: childCount)
        }
    }
    
    private func getPrices() {
        guard var params = info else {
            return
        }
        params.no_of_adult = menCount.stringValue
        params.no_of_child = childCount.stringValue
        
        network.getVisaPrice(prm: params).subscribe(onNext: { [unowned self] pr in
            self.childTotalLbl.text = pr.visaPrice.first?.adultPrice.priced
            self.childTotalLbl.text = pr.visaPrice.first?.adultPrice.priced
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    @IBAction func childPlusAction(_ sender: Any) {
        childCount = childCount + 1
    }
    
    @IBAction func childMinusAction(_ sender: Any) {
        let current = childCount
        if current > 0 {
            childCount = current - 1
        }
    }
    
    @IBAction func adultPlusAction(_ sender: Any) {
        menCount = menCount + 1
    }
    
    @IBAction func adultMinusAction(_ sender: Any) {
        let current = menCount
        if current > 0 {
            menCount = current - 1
        }
    }
    
    var result = PublishSubject<PassangerCount>()
    
    @IBAction func confirmAction(_ sender: Any) {
        result.onNext((menCount, childCount, totolCost))
        dismiss(animated: true, completion: nil)
    }
    
    func setTotalFooterCount(men: Int, child: Int) {
        let str = "عدد المسافرين" + " : " + " \(child) " + "اطفال" + "," + " \(men) " + "بالغين"
        let attributedString = NSMutableAttributedString(string: str,
                                                         attributes: [
                                                             .font: UIFont(name: AppFonts.boldFont, size: 14.0)!,
                                                             .foregroundColor: UIColor(white: 61.0 / 255.0, alpha: 1.0),
                                                         ])
        attributedString.addAttribute(.font, value: UIFont(name: AppFonts.regularFont, size: 14.0)!, range: NSRange(location: 0, length: 15))
        countLbl.attributedText = attributedString
    }
}

extension String {
    var priced: String {
        return "\(self) SR"
    }
}
