//
//  Progress.swift
//  Direct
//
//  Created by abuzeid on 5/15/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import ARSLineProgress

protocol Loader {
    static func show()
    static func hide()
}
final class Progress:Loader{
    static func show(){
        ARSLineProgress.show()
    }
    static func hide(){
        ARSLineProgress.hide()
    }
}

