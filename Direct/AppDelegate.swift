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
        setRootController()
        setupGlobalAppearance()
        setLanguage()
//        for familyName in UIFont.familyNames {
//            print(UIFont.fontNames(forFamilyName: familyName))
//        }

        return true
    }

    private func setLanguage() {
        UserDefaults.standard.set(["ar"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }

    func setupGlobalAppearance() {
        window?.tintColor = UIColor.white
        // global Appearance settings
        let customFont = UIFont.appRegularFontWith(size: 17)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: customFont], for: .normal)
        UITextField.appearance().substituteFontName = AppFonts.regularFont
        UILabel.appearance().substituteFontName = AppFonts.regularFont
        UILabel.appearance().substituteFontNameBold = AppFonts.boldFont
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: AppFonts.regularFont, size: 11)!, NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
    }

    private func setRootController() {
        let root = UIStoryboard.main.instantiateViewController(withIdentifier: StoryBoardIds.rootController.id) as! RootNavigationViewController
        
        
//        let x = UIStoryboard.visa.instantiateViewController(withIdentifier: "VisaReqConfirmationController")

        window?.rootViewController = root
        window?.makeKeyAndVisible()
        navigator = AppNavigator(root: root)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
//            let x = VisaRequestParams()
//            x.no_of_adult = "1"
//            x.no_of_child = "1"
//            try? AppNavigator().push(.passangersInfoScreen(x))
//        })
    }
}

