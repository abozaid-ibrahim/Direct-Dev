//
//  LoginViewController.swift
//  Direct
//
//  Created by abuzeid on 4/24/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func submitLogin(_ sender: Any) {
        //TODO:
        // you should recieve the depencey from out side
        AppNavigator(root: self.navigationController! as! RootNavigationViewController).show(.homeScreen)
    }
    
   

}
