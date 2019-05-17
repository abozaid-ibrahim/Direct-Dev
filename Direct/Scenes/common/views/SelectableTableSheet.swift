//
//  SelectableTableSheet.swift
//  Direct
//
//  Created by abuzeid on 4/29/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

import PanModal
import RxSwift
import UIKit
enum CellStyle {
    case textCenter, textWithArrow
}

final class SelectableTableSheet: UIViewController, PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil//tableView
    }
    var shortFormHeight: PanModalHeight = .contentHeight(330)

    // set these var from outside
    var data: [String]?
    var style: CellStyle = .textWithArrow
    // listen to selected
    var selectedItem = PublishSubject<String>()
    @IBOutlet var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableDataSource()
        setONSelect()
        
    }
    private func setONSelect(){
        tableView.rx.itemSelected.asObservable().subscribe({[unowned self] event in
            switch event.event{
            case .next(let indexPath):
                self.selectedItem.onNext(self.data?[indexPath.row] ?? "")
            default:
                break
                
            }
        }).disposed(by: disposeBag)
    }
    private func setTableDataSource(){
        guard let datasource = data else {
            return
        }
        switch style {
        case .textCenter:
            tableView.register(UINib(nibName: TextTableCell.cellId, bundle: nil), forCellReuseIdentifier: TextTableCell.cellId)
            
            Observable<[String]>.just(datasource)
                .bind(to: tableView.rx.items(cellIdentifier: TextTableCell.cellId)) { _, model, cell in
                    let mycell = (cell as! TextTableCell)
                    mycell.setCellData(model)
                }.disposed(by: disposeBag)
        case .textWithArrow:
            tableView.register(UINib(nibName: SingleRowTableCell.cellId, bundle: nil), forCellReuseIdentifier: SingleRowTableCell.cellId)
            
            Observable<[String]>.just(datasource)
                .bind(to: tableView.rx.items(cellIdentifier: SingleRowTableCell.cellId)) { _, model, cell in
                    let mycell = (cell as! SingleRowTableCell)
                    mycell.setCellData(model)
                }.disposed(by: disposeBag)
        }
    }
}

protocol Selectable {
    associatedtype DataModel
    associatedtype TableCell
    func setTableDataAndCell(data: [DataModel], cell: TableCell)
}
