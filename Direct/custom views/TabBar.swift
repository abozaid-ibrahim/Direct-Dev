//
//  TabBar.swift
//  Direct
//
//  Created by abuzeid on 5/17/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import RxSwift
import RxGesture

typealias Action = ()->()
class TabBar: UIView {
    
    
    let stackContainer:UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis  = .horizontal
        stack.spacing = 10
        return stack
    }()
    var selector :UIView {
        let view = UIView()
        view.backgroundColor = UIColor.appMango
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 4).isActive = true
        
        return view
    }
    
    var label:UILabel {
        let lbl = UILabel()
        
        return lbl
    }
    let bag = DisposeBag()
    private var tabsSep: [UIView] = []
    typealias TAB = (String,Action)
    func createUI(tabs:[TAB]){
        for tab in tabs{
            let lbl = UILabel()
            lbl.textAlignment = .center
            lbl.text = tab.0
            lbl.font = UIFont(name: AppFonts.regularFont, size: 15)
            
            let sel = selector
            let view = UIStackView(arrangedSubviews: [lbl,sel])
            view.alignment = .fill
            view.axis = .vertical
            view.spacing = 5
            view.rx.tapGesture().asObservable().skip(1).subscribe({ event in
                tab.1()
                for sep in self.tabsSep{
                    sep.alpha = 0.0
                }
                sel.alpha = 1.0
                
            }).disposed(by: bag)
            self.tabsSep.append(sel)
            stackContainer.addArrangedSubview(view)
        }
        addSubview(stackContainer)
        stackContainer.sameBoundsTo(parentView: self)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI(tabs: [])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createUI(tabs: [])
    }
    init(tabs: [(String, Action)]) {
        super.init(frame: CGRect(origin: .zero, size: CGSize(width:200,height:40)))
        createUI(tabs: tabs)
    }
    
}
