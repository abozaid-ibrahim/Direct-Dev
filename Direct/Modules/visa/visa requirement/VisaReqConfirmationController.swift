//
//  VisaReqConfirmationController.swift
//  Direct
//
//  Created by abuzeid on 5/31/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import UIKit

class VisaReqConfirmationController: UIViewController {
    let ids = ["cell1", "cell22", "cell3", "cell4"]
    var visaRequestData: VisaRequestParams?
    private let disposeBag = DisposeBag()
    var tableHeight = PublishSubject<CGFloat>()
    let headerHeight = CGFloat(90)
    private let contentSizeKey = "contentSize"
    typealias ConfrimTableRow = (String, Bool, Int)
    var passangers: [ConfrimTableRow] = []
    
    // MARK: IBuilder ====================================>>
    
    @IBOutlet var placeHolderLbls: [UILabel]!
    @IBOutlet var countryLbl: UILabel!
    @IBOutlet var visaTypeLbl: UILabel!
    @IBOutlet var bioLocLbl: UILabel!
    @IBOutlet var relationlbl: UILabel!
    @IBOutlet var pasangerCountLbl: UILabel!
    @IBOutlet var datelbl: UILabel!
    @IBOutlet var hostsLbl: UILabel!
    @IBOutlet var pckDateLbl: UILabel!
    @IBOutlet var checkoutFooter: CheckoutFooter!
    @IBOutlet var tableHeightConstrain: NSLayoutConstraint!
    @IBOutlet var passangersTable: UITableView!
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
        
        passangersTable.rx.observeWeakly(CGSize.self, contentSizeKey).subscribe(onNext: { [unowned self] _ in
//            self.tableHeight.onNext(self.passangersTable.contentSize.height + self.headerHeight)
            self.tableHeightConstrain.constant = self.passangersTable.contentSize.height
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
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
        checkoutFooter.valueText = info.totalCost ?? "".priced
        
        for _ in 0..<(info.no_of_adult ?? "0").intValue {
            passangers.append(("بالغ", false, 1))
        }
        for _ in 0..<(info.no_of_child ?? "0").intValue {
            passangers.append(("طفل", false, 0))
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
    func updateTableWithSuccessInputs(){
         let filled = passangersInfoScreen.successInputIndexes 
        for item in filled.enumerated(){
            self.passangers[item.element].1 = true
        }
        setupTable()
    }
    func setupTable() {
        Observable.just(passangers)
            .bind(to: passangersTable.rx.items(cellIdentifier: VisaConfrimationPassangerCell.id, cellType: VisaConfrimationPassangerCell.self)) { pos, element, cell in
                cell.textLbl.text =  element.0  + " " + "\(pos + 1)" 
                cell.statuxIcon.image = element.1 ? #imageLiteral(resourceName: "path4") : #imageLiteral(resourceName: "rightGreen")
            }
            .disposed(by: disposeBag)
    }
    lazy var passangersInfoScreen = Destination.passangersInfoScreen(visaRequestData!).controller() as! PassangersInputViewViewController
    
    
    @IBAction func passangersInfoAction(_ sender: Any) {
     gotoFormsScreen()
    }
    func gotoFormsScreen(index:Int = 0){
        passangersInfoScreen.defaultTabSelection = index
        navigationController?.pushViewController(passangersInfoScreen, animated: true)
    }
}

class VisaConfrimationPassangerCell: UITableViewCell {
    let disposeBag = DisposeBag()
    static let id = "VisaConfrimationPassangerCell"
    @IBOutlet var textLbl: UILabel!
    @IBOutlet var statuxIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
    }
}
