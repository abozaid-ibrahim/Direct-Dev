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
    var tableHeight = PublishSubject<CGFloat>()
    private let contentSizeKey = "contentSize"
    typealias TypeIndex = Int
    typealias ConfrimTableRow = (String, Bool, Int, TypeIndex)
    var passangers: [ConfrimTableRow] = []
    var reqID: String?

    // MARK: IBuilder ====================================>>

    @IBOutlet var placeHolderLbls: [UILabel]!
    @IBOutlet var countryLbl: UILabel!
    @IBOutlet var visaTypeLbl: UILabel!
    @IBOutlet var bioLocLbl: UILabel!
    @IBOutlet var relationlbl: UILabel!
    @IBOutlet var pasangerCountLbl: UILabel!
    @IBOutlet var datelbl: UILabel!
    @IBOutlet var sponsorsLbl: UILabel!
    @IBOutlet var pckDateLbl: UILabel!
    @IBOutlet var sponsorsStatusIV: UIImageView!
    @IBOutlet var checkoutFooter: CheckoutFooter!
    @IBOutlet var tableHeightConstrain: NSLayoutConstraint!
    @IBOutlet var passangersTable: UITableView!
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
            try! AppNavigator().push(.paymentMethod(self.visaRequestData!))
        }

        passangersTable.rx.observeWeakly(CGSize.self, contentSizeKey).subscribe(onNext: { [unowned self] value in
            let vertical = self.checkoutFooter.frame.minY - self.pickDateView.frame.maxY
            if vertical <= 20 {
                self.passangersTable.isScrollEnabled = true
                self.passangersTable.bounces = true
                self.passangersTable.bouncesZoom = true
                self.tableHeightConstrain.constant = 250
            } else {
                self.tableHeightConstrain.constant = value?.height ?? 100
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)

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
            passangers.append((Str.adult, false, 1, index + 1))
        }
        for index in 0 ..< (info.no_of_child ?? "0").intValue {
            passangers.append((Str.child, false, 0, index + 1))
        }
        setupTable()
        passangersTable.rx
            .itemSelected
            .subscribe(onNext: { indexPath in
                self.gotoFormsScreen(index: indexPath.row)
            })
            .disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTableWithSuccessInputs()
    }

    func updateTableWithSuccessInputs() {
        let filled = passangersInfoScreen.successInputIndexes
        for item in filled.enumerated() {
            passangers[item.element].1 = true
        }
        setupTable()
    }

    func setupTable() {
        Observable.just(passangers)
            .bind(to: passangersTable.rx.items(cellIdentifier: VisaConfrimationPassangerCell.id, cellType: VisaConfrimationPassangerCell.self)) { _, element, cell in
                cell.textLbl.text = element.0 + " \(element.3)"
                cell.statuxIcon.image = element.1 ? #imageLiteral(resourceName: "path4") : #imageLiteral(resourceName: "rightGreen")
            }
            .disposed(by: disposeBag)
    }

    lazy var passangersInfoScreen = Destination.passangersInfoScreen(visaRequestData!).controller() as! PassangersInputViewViewController

    @IBAction func passangersInfoAction(_: Any) {
        gotoFormsScreen()
    }

    func gotoFormsScreen(index: Int = 0) {
        navigationController?.pushViewController(passangersInfoScreen, animated: true)
        passangersInfoScreen.defaultTabSelection.onNext(index)
    }
}
