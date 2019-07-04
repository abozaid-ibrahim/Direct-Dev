//
//  VisaRequirementViewModel.swift
//  Direct
//
//  Created by abuzeid on 7/4/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxOptional
import RxSwift

class VisaRequirementsViewModel {
    let data = PublishSubject<[ReqDataSection]>()
    let headerData = PublishSubject<RequirementPage>()

    private let network = ApiClientFacade()
    private let disposeBag = DisposeBag()
    private var staticHeaderItem:ReqDataSection{
        let info = ReqInformation(isInfo: nil, title: Str.reqPapers, icon: "icons8Documents", image: nil, desc: nil)
        return ReqDataSection(info, shouldCollapse: true,hideAccessory: true)
    }
    func getDataRemotely(for cid: String?) {
        guard let id = cid else {
            return
        }
        Progress.show()

        network.getVisaRequirements(country: id).subscribe(onNext: { [unowned self] response in
            guard let requirement = response.requirementPage?.first else { return }
            var reqsNInfo:[ReqDataSection] = [self.staticHeaderItem]
          reqsNInfo.append(contentsOf: (requirement.requirements ?? [])
                .map { ReqDataSection($0,shouldCollapse: true) })
            reqsNInfo.append(contentsOf: (requirement.informations ?? [])
                .map { ReqDataSection($0,shouldCollapse: false,hideAccessory: true) })
            
            self.data.onNext(reqsNInfo)
            self.headerData.onNext(requirement)
            Progress.hide()
        }, onError: { _ in
            Progress.hide()
        }).disposed(by: disposeBag)
    }
    
    
}

class ReqDataSection {
    var shouldCollapse = false
    var opened: Bool = false
    var data: ReqInformation
    var hideAccessory:Bool
    init(_ req: ReqInformation,shouldCollapse:Bool = false, hideAccessory:Bool = false) {
        data = req
        opened = shouldCollapse ? false : true
        self.shouldCollapse = shouldCollapse
        self.hideAccessory = hideAccessory
    }
}
