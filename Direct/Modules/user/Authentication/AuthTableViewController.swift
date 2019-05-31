//
//  AuthTableViewController.swift
//  Daleel
//
//  Created by abdelrahman mohamed on 5/2/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import UIKit
import GenericCellControllers

enum AuthType {
    case login, register, recoverPassword, verifyPhoneNumber, createNewPassword(key: String), verifyPhoneNumberLogin
}

class AuthTableViewController: UITableViewController {

    private let cellControllerFactory = AuthCellControllerFactory()
    private var cellControllers: [TableCellController] = []
    var type: AuthType {
        didSet {
            loadData()
        }
    }

    init(_ type: AuthType) {
        self.type = type
        super.init(style: .plain)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.keyboardDismissMode = .interactive
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadData()
    }

    func loadData() {
        cellControllerFactory.registerCells(on: tableView)

        let data: [AuthElement]
        switch type {
        case .login:
            data = AuthViewsBuilder.loginViewData
        case .register:
            data = AuthViewsBuilder.signupViewData
        case .verifyPhoneNumber:
            data = AuthViewsBuilder.activationCodeData
        case .verifyPhoneNumberLogin:
            data = AuthViewsBuilder.activationCodeDataWait
        case .recoverPassword:
            data = AuthViewsBuilder.forgetPasswordData
        case .createNewPassword:
            data = AuthViewsBuilder.newPasswordData
        }

        cellControllers = cellControllerFactory.cellControllers(from: data, coordinator: AuthCoordinator(viewController: self))

        tableView.reloadData(with: .fade)
    }

    // MARK: - Table view data source & delegates
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellControllers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellControllers[indexPath.row].cellFromReusableCellHolder(tableView, forIndexPath: indexPath)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellControllers[indexPath.row].didSelectCell()
    }
}

extension UITableView {
    func reloadData(with animation: UITableView.RowAnimation) {
        reloadSections(IndexSet(integersIn: 0..<numberOfSections), with: animation)
    }
}
