//
//  PassangerInputsSection.swift
//  Direct
//
//  Created by abuzeid on 6/15/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxSwift
protocol PassangerInputsSection: UIView {
    var contentHeight: BehaviorSubject<CGFloat> { get set }
    func isInputsValid() -> Bool
    var formType: CountriesIDs? { get set }
    var params: VisaRequirementsParams? { get set }
}
