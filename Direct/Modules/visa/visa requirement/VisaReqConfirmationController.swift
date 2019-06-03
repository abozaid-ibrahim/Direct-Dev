//
//  VisaReqConfirmationController.swift
//  Direct
//
//  Created by abuzeid on 5/31/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class VisaReqConfirmationController: UIViewController {
    let ids = ["cell1", "cell22", "cell3", "cell4"]
    var visaRequestData: VisaRequestParams?

    // MARK: IBuilder ====================================>>

    @IBOutlet var placeHolderLbls: [UILabel]!
    @IBOutlet var countryLbl: UILabel!
    @IBOutlet var visaTypeLbl: UILabel!
    @IBOutlet var bioLocLbl: UILabel!
    @IBOutlet var relationlbl: UILabel!
    @IBOutlet var pasangerCountLbl: UILabel!
    @IBOutlet var datelbl: UILabel!
    @IBOutlet var adultsLbl: UILabel!
    @IBOutlet var childLbl: UILabel!
    @IBOutlet var childsRowView: UIStackView!
    @IBOutlet var hostsLbl: UILabel!
    @IBOutlet var pckDateLbl: UILabel!
    @IBOutlet weak var checkoutFooter: CheckoutFooter!
    //===================================================<<
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "طلب تأشيرة"
        view.backgroundColor = UIColor.appVeryLightGray
        for lbl in placeHolderLbls{
            lbl.font = UIFont.appRegularFontWith(size: 10)
        }
        fillUIWithData()
        checkoutFooter.action = {[weak self] in
             guard let self = self else {return}
            try! AppNavigator().push(.paymentMethod(self.visaRequestData!))

        }
    }

    private func fillUIWithData() {
        guard let info = visaRequestData else {
            return
        }
        countryLbl.text = info.countryName
        datelbl.text = info.travel_date
        visaTypeLbl.text = info.visatypeText
        bioLocLbl.text = info.biometry_loc
        pasangerCountLbl.text = info.no_of_adult + " " + "بالغ" + ", " + info.no_of_child + " " + "طفل"
        relationlbl.text = info.relation_with_travelersText
        adultsLbl.text = "بالغ" + " " + info.no_of_adult
        childLbl.text = "طفل" + " " + info.no_of_child
        
        checkoutFooter.valueText = info.totalCost ?? "" .priced
    }

    @IBAction func passangersInfoAction(_ sender: Any) {
        try! AppNavigator().push(.passangersInfoScreen)

    }
}

