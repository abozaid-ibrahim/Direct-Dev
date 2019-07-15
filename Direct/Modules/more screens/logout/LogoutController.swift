//
//  LogoutController.swift
//  Direct
//
//  Created by abuzeid on 7/15/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
func showOptions(){
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    
    let search = UIAlertAction(title: Str.logout, style: .default, handler: { _ in

    })
    let cancel = UIAlertAction(title: Str.cancel, style: .cancel, handler:nil)
    alert.addAction(search)
    alert.addAction(cancel)
}
