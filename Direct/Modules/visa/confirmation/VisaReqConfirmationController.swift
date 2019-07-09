//
//  VisaReqConfirmationController.swift
//  Direct
//
//  Created by abuzeid on 5/31/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxCocoa
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
//    private var passangers: [ConfirmPassangerItem] = []
    var reqID: String?

    // MARK: IBuilder ====================================>>

    @IBOutlet var relationsPlaceholderLbl: UILabel!
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
    @IBOutlet private var passangersTable: UITableView!
    @IBOutlet private var pickDateView: UIView!
    @IBOutlet private var sponsersView: UIView!
    @IBOutlet private var dateStatusIcon: UIImageView!
    //===================================================<<

    let viewModel = VisaReqCofirmationViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCheckoutFooter()
        bindPassangersTable()
        fillUIWithData()
       // setTablViewHeight()
        setSponsorsView()
        setupPickingDate()
    }

    private func setupPickingDate() {
        viewModel.showBioOptions(click: pckDateLbl.rx.tapGesture().when(.recognized))
        viewModel.selectedBioOption.map { _ in #imageLiteral(resourceName: "successCircle") }
            .bind(to: dateStatusIcon.rx.image).disposed(by: disposeBag)
        viewModel.selectedBioOption.map { $0.name }.debug()
            .bind(to: pckDateLbl.rx.text).disposed(by: disposeBag)
    }

    private func setTablViewHeight() {
        passangersTable.rx.observeWeakly(CGSize.self, contentSizeKey)
            .subscribe(onNext: { [unowned self] value in
                let vertical = self.checkoutFooter.frame.minY - self.pickDateView.frame.maxY
                if vertical <= 20 {
                    self.passangersTable.isScrollEnabled = true
                    self.passangersTable.bounces = true
                    self.passangersTable.bouncesZoom = true
                } else {
                    self.passangersTable.isScrollEnabled = false
                }
            }).disposed(by: disposeBag)
    }

    private func setupUI() {
        title = Str.requestingVisa
        relationlbl.applyStyle(.normalBoldText)
        pasangerCountLbl.applyStyle(.normalBoldText)
        view.backgroundColor = UIColor.appVeryLightGray
        for lbl in placeHolderLbls {
            lbl.font = UIFont.appRegularFontWith(size: 10)
        }
    }

    private func setupCheckoutFooter() {
        bindEnableButton()
        checkoutFooter.action = { [weak self] in
            guard let self = self else { return }
            guard let info = self.visaRequestData,
                let id = Int(info.requestID ?? "0"),
                let cost = info.totalCost else {
                return
            }
            try! AppNavigator().push(Destination.paymentMethod(thanksUrl: info.thankYouUrl, requestID: id, totalCost: cost))
        }
    }

    private func bindEnableButton() {
        viewModel.enablePayment.bind(to: checkoutFooter.btn.rx.isEnabled).disposed(by: disposeBag)
        viewModel.enablePayment
            .map { $0 ? UIColor.appPumpkinOrange : UIColor.disabledBtnBg }
            .bind(to: checkoutFooter.btn.rx.backgroundColor)
            .disposed(by: disposeBag)
    }

    private func setSponsorsView() {
        guard let id = self.visaRequestData?.country_id.intValue else { return }
        if id == CountriesIDs.TR.rawValue {
            sponsersView.isHidden = true
            viewModel.validSponsors.onNext(true)
        } else {
            sponsersView.rx.tapGesture()
                .when(.recognized)
                .subscribe(onNext: { _ in
                    try! AppNavigator().push(self.sponsorsConfrimation)

                }).disposed(by: disposeBag)
        }
    }

    private lazy var sponsorsConfrimation: SponsersViewController = {
        let dest = Destination.sponsersInfoScreen(self.visaRequestData!, reqID: self.reqID ?? "")
        let vc = dest.controller() as! SponsersViewController
        vc.sponsorsIConStatus.map { $0 ? #imageLiteral(resourceName: "successCircle") : #imageLiteral(resourceName: "group11") }.bind(to: sponsorsStatusIV.rx.image).disposed(by: disposeBag)
        vc.sponsorsIConStatus.bind(to: self.viewModel.validSponsors).disposed(by: disposeBag)
        return vc
    }()

    lazy var passangersInfoScreen: PassangersInputViewViewController = {
        let vc = Destination.passangersInfoScreen(visaRequestData!).controller() as! PassangersInputViewViewController
        vc.sucessIndex.bind(to: self.viewModel.successIndices).disposed(by: disposeBag)
        return vc
    }()

    private func fillUIWithData() {
        guard let info = visaRequestData else {
            return
        }
        viewModel.loadPassangers(with: info)

        countryLbl.text = info.countryName
        datelbl.text = info.travel_date
        visaTypeLbl.text = info.visatypeText
        bioLocLbl.text = info.biometry_loc
        pasangerCountLbl.text = info.no_of_adult + " " + Str.adult + ", " + info.no_of_child + " " + Str.child
        if info.relation_with_travelersText.isValidText {
            relationlbl.text = info.relation_with_travelersText
            relationlbl.alpha = 1.0
            relationsPlaceholderLbl.alpha = 1.0
        } else {
            relationlbl.alpha = 0.0
            relationsPlaceholderLbl.alpha = 0.0
        }

        checkoutFooter.valueText = info.totalCost ?? "".priced

        passangersTable.rx
            .itemSelected
            .subscribe(onNext: { indexPath in
                self.gotoFormsScreen(index: indexPath.row)
            })
            .disposed(by: disposeBag)
    }

    func bindPassangersTable() {
        viewModel.tablePassangers.observeOn(MainScheduler.instance)
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
