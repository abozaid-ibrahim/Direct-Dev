//
//  User.swift
//  Direct
//
//  Created by abuzeid on 4/25/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
//this is the ui model
protocol User {
    var isLoggedIN:Bool{get set}
}
//this is the business Model
class UserEntity:User{
    var isLoggedIN: Bool = false
    
    
    
}
