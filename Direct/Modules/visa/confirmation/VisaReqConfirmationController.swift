//
//  VisaReqConfirmationController.swift
//  Direct
//
//  Created by abuzeid on 5/31/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxGesture
import RxSwift
import UIKit

class VisaReqConfirmationController: UIViewController {
    private let ids = ["cell1", "cell22", "cell3", "cell4"]
    var visaRequestData: VisaRequestParams?
    private let disposeBag = DisposeBag()
    private var tableHeight = PublishSubject<CGFloat>()
    private let contentSizeKey = "contentSize"
    typealias TypeIndex = Int
    private var passangers: [ConfirmPassangerItem] = []
    var reqID: String?

    // MARK: IBuilder ====================================>>

    @IBOutlet private var placeHolderLbls: [UILabel]!
    @IBOutlet private var countryLbl: UILabel!
    @IBOutlet private var visaTypeLbl: UILabel!
    @IBOutlet private var bioLocLbl: UILabel!
    @IBOutlet private var relationlbl: UILabel!
    @IBOutlet private var pasangerCountLbl: UILabel!
    @IBOutlet private var datelbl: UILabel!
    @IBOutlet private var sponsorsLbl: UILabel!
    @IBOutlet private var pckDateLbl: UILabel!
    @IBOutlet private var sponsorsStatusIV: UIImageView!
    @IBOutlet private var checkoutFooter: CheckoutFooter!
    @IBOutlet private var tableHeightConstrain: NSLayoutConstraint!
    @IBOutlet private var passangersTable: UITableView!
    @IBOutlet private var pickDateView: UIView!
    @IBOutlet private var sponsersView: UIView!

    //===================================================<<
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "طلب تأشيرة"
        view.backgroundColor = UIColor.appVeryLightGray
        for lbl in placeHolderLbls {
            lbl.font = UIFont.appRegularFontWith(size: 10)
        }
        fillUIWithData()
        checkoutFooter.action = { [weak self] in
            guard let self = self else { return }
            guard let info = self.visaRequestData,
                let id = Int(info.requestID ?? "0"),
                let cost = info.totalCost else {
                return
            }
            try! AppNavigator().push(Destination.paymentMethod(requestID: id, totalCost: cost))
        }

        passangersTable.rx.observeWeakly(CGSize.self, contentSizeKey)
            .subscribe(onNext: { [unowned self] value in
                let vertical = self.checkoutFooter.frame.minY - self.pickDateView.frame.maxY
                if vertical <= 20 {
                    self.passangersTable.isScrollEnabled = true
                    self.passangersTable.bounces = true
                    self.passangersTable.bouncesZoom = true
                    self.tableHeightConstrain.constant = 250
                } else {
                    self.tableHeightConstrain.constant = value?.height ?? 100
                }
            }).disposed(by: disposeBag)

        sponsersView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                try! AppNavigator().push(self.sponsorsConfrimation)

            }).disposed(by: disposeBag)
    }

    private lazy var sponsorsConfrimation: SponsersViewController = {
        let dest = Destination.sponsersInfoScreen(self.visaRequestData!, reqID: self.reqID ?? "")
        let vc = dest.controller() as! SponsersViewController
        vc.sponsorsIConStatus.map { $0 ? #imageLiteral(resourceName: "successCircle") : #imageLiteral(resourceName: "group11") }.bind(to: sponsorsStatusIV.rx.image).disposed(by: disposeBag)

        return vc
    }()

    lazy var passangersInfoScreen: PassangersInputViewViewController = {
        let vc = Destination.passangersInfoScreen(visaRequestData!).controller() as! PassangersInputViewViewController
        vc.sucessIndex.subscribe(onNext: { [unowned self] _ in
            self.updateTableWithSuccessInputs()
        }).disposed(by: disposeBag)

        return vc
    }()

    private func fillUIWithData() {
        guard let info = visaRequestData else {
            return
        }
        countryLbl.text = info.countryName
        datelbl.text = info.travel_date
        visaTypeLbl.text = info.visatypeText
        bioLocLbl.text = info.biometry_loc
        pasangerCountLbl.text = info.no_of_adult + " " + Str.adult + ", " + info.no_of_child + " " + Str.child
        relationlbl.text = info.relation_with_travelersText
        checkoutFooter.valueText = info.totalCost ?? "".priced

        for index in 0 ..< (info.no_of_adult ?? "0").intValue {
            passangers.append(ConfirmPassangerItem(text: Str.adult, isFormFilled: false, index: index + 1, userType: .adult))
        }
        for index in 0 ..< (info.no_of_child ?? "0").intValue {
            passangers.append(ConfirmPassangerItem(text: Str.child, isFormFilled: false, index: index + 1, userType: .child))
        }
        setupTable()
        passangersTable.rx
            .itemSelected
            .subscribe(onNext: { indexPath in
                self.gotoFormsScreen(index: indexPath.row)
            })
            .disposed(by: disposeBag)
    }

    func updateTableWithSuccessInputs() {
        let filled = passangersInfoScreen.successInputIndexes
        for item in filled.enumerated() {
            passangers[item.element].isFormFilled = true
        }
        setupTable()
    }

    func setupTable() {
        Observable.just(passangers)
            .bind(to: passangersTable.rx.items(cellIdentifier: VisaConfrimationPassangerCell.id, cellType: VisaConfrimationPassangerCell.self)) { _, element, cell in
                cell.textLbl.text = element.text + " \(element.index)"
                cell.statuxIcon.image = element.isFormFilled ? #imageLiteral(resourceName: "path4") : #imageLiteral(resourceName: "rightGreen")
            }
            .disposed(by: disposeBag)
    }

    @IBAction func passangersInfoAction(_: Any) {
        gotoFormsScreen()
    }

    func gotoFormsScreen(index: Int = 0) {
        passangersInfoScreen.defaultTabSelection = index
        navigationController?.pushViewController(passangersInfoScreen, animated: true)
    }
}

struct ConfirmPassangerItem {
    let text: String
    var isFormFilled: Bool
    var index: Int
    var userType: UserAge // child or adult
}

enum UserAge: Int {
    case adult = 1
    case child = 2
}
