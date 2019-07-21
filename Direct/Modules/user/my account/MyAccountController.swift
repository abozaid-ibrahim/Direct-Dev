//
//  MyAccountController.swift
//  Direct
//
//  Created by abuzeid on 5/1/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import PanModal
import RxSwift
import Social
import UIKit

final class MyAccountController: UIViewController, StyledActionBar {
    var disposeBag = DisposeBag()
    @IBOutlet private var logoutBtn: UIButton!
    @IBOutlet private var langView: UIView!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var langLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(nibWithCellClass: AboutUsTableCell.self)
        tableView.backgroundColor = .clear
        view.backgroundColor = .appVeryLightGray
        tableView.separatorColor = UIColor.appVeryLightGray
        tableView.separatorStyle = .singleLine
        tabBarItem.image = #imageLiteral(resourceName: "More")
        setupFooter()
      
    }
    private func setupFooter(){
        langLbl.text = AppLanguage.currentLangName
        langLbl.font = .appRegularFontWith(size: 13)
        langView.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                let vc = LanguagesViewController()
                vc.selectedLang.bind(to: self.langLbl.rx.text).disposed(by: self.disposeBag)
                self.navigationController?.pushViewController(vc)
                
            }).disposed(by: disposeBag)
        logoutBtn.localizedFont = .bold(15)
        logoutBtn.setTitleColor(.appMango, for: .normal)
        logoutBtn.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                
                let alert = UIAlertController(title: Str.logout, message: Str.sureToLogout.localized(), preferredStyle: .alert)
                
                let search = UIAlertAction(title: Str.logout.localized(), style: .default, handler: { _ in
                    
                })
                let cancel = UIAlertAction(title: Str.cancel.localized(), style: .cancel, handler: nil)
                alert.addAction(search)
                alert.addAction(cancel)
                alert.applyAppStyle()
                self.present(alert, animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupActionBar(.withTitle(Str.more.localized()))
    }
    
    @IBAction func login(_: Any) {
        try! AppNavigator().present(.loginView)
    }
}

extension MyAccountController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MoreDataRep.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: AboutUsTableCell.self)
        cell.cellTitleLabel.text = MoreDataRep.allCases[indexPath.row].title.localized
        cell.iconImage.image = MoreDataRep.allCases[indexPath.row].image
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MoreDataRep.allCases[indexPath.row].viewController
        let presentation = MoreDataRep.allCases[indexPath.row].presentationType
        if presentation == .popover {
            present(vc, animated: true, completion: nil)
        } else {
            navigationController?.pushViewController(vc)
        }
    }
}
