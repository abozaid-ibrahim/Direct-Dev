//
//  AppDelegate.swift
//  Direct
//
//  Created by abuzeid on 4/24/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var navigator:Navigator!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

setRootController()
        return true
    }
    private func setRootController(){
        let root  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RootNavigationViewController") as! RootNavigationViewController
     
        self.window?.rootViewController = root
        self.window?.makeKeyAndVisible()
        
        self.navigator = AppNavigator(root: root )
    }
    
    
}

