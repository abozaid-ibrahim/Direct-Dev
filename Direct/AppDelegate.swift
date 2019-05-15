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
    var navigator: Navigator!
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.tintColor = UIColor.white
        setRootController()
        for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
setupGlobalAppearance()
        return true
    }
    func setupGlobalAppearance(){
        
        //global Appearance settings
        let customFont = UIFont.appRegularFontWith(size: 17)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: customFont], for: .normal)
        UITextField.appearance().substituteFontName = AppFonts.regularFont
        UILabel.appearance().substituteFontName = AppFonts.regularFont
        UILabel.appearance().substituteFontNameBold = AppFonts.boldFont
        
    }
    private func setRootController() {
        let root = UIStoryboard.main.instantiateViewController(withIdentifier: StoryBoardIds.rootController.id) as! RootNavigationViewController
        window?.rootViewController = root
        window?.makeKeyAndVisible()
        navigator = AppNavigator(root: root)
    }
}
