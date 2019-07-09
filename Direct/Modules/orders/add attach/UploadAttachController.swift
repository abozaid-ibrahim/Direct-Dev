//
//  UploadAttachController.swift
//  Direct
//
//  Created by abuzeid on 7/9/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import PanModal
import RxSwift
import UIKit

class UploadAttachController: UIViewController, PanModalPresentable {
    private let viewModel = UploadAttachViewModel()
    @IBOutlet private var nameField: FloatingTextField!
    @IBOutlet private var idField: FloatingTextField!
    @IBOutlet private var personalDocView: ImagePickerView!
    var panScrollable: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func submitAction(_ sender: Any) {
        viewModel.submit(vname: "")
    }
}