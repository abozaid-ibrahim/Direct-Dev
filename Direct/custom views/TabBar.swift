//
//  TabBar.swift
//  Direct
//
//  Created by abuzeid on 5/17/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxGesture
import RxSwift
import UIKit

public typealias TAB = (String, () -> ()?)

class TabBar: UIView {
    let stackContainer: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()

    func createContentStack()->UIStackView{
            let stack = UIStackView()
            stack.alignment = .fill
            stack.distribution = .fill
            stack.axis = .horizontal
            stack.spacing = 10
            return stack
    }

    var selector: UIView {
        let view = UIView()
        view.backgroundColor = UIColor.appMango
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 4).isActive = true

        return view
    }

    var label: UILabel {
        let lbl = UILabel()

        return lbl
    }

    var icon: UIImageView {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "path4")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.widthAnchor.constraint(equalToConstant: 20).isActive = true
        iv.isHidden = true
        return iv
    }

    let bag = DisposeBag()
    private var tabsSep: [UIView] = []
    func createUI(tabs: [TAB]) {
        for tab in tabs {
            let content = createContentStack()
            let lbl = UILabel()
            lbl.textAlignment = .center
            lbl.text = tab.0
            lbl.font = UIFont(name: AppFonts.regularFont, size: 15)
            content.addArrangedSubview(icon)
            content.addArrangedSubview(lbl)
            let sel = selector
            let view = UIStackView(arrangedSubviews: [content, sel])
            view.alignment = .fill
            view.axis = .vertical
            view.spacing = 5
            view.rx.tapGesture().asObservable().skip(1).subscribe { _ in
                tab.1()
                for sep in self.tabsSep {
                    sep.alpha = 0.0
                }
                sel.alpha = 1.0

            }.disposed(by: bag)
            tabsSep.append(sel)
            stackContainer.addArrangedSubview(view)
        }
        // set default selection 1
        setFirstDefaultSelector()
        addSubview(stackContainer)
        stackContainer.sameBoundsTo(parentView: self)
    }

    private func setFirstDefaultSelector() {
        for sep in tabsSep.enumerated() {
            if sep.offset == 0 {
                sep.element.alpha = 1.0

            } else {
                sep.element.alpha = 0.0
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI(tabs: [])
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createUI(tabs: [])
    }

    init(tabs: [TAB]) {
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 40)))
        createUI(tabs: tabs)
    }
}
