//
//  AppDelegate.swift
//  Direct
//
//  Created by abuzeid on 4/24/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import IQKeyboardManagerSwift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navigator: Navigator!

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setRootController()
        setupGlobalAppearance()
        setLanguage()

        setupKeyboardManager()
        return true
    }

    private func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.enableAutoToolbar = false
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
        window?.rootViewController = root
        window?.makeKeyAndVisible()
        navigator = AppNavigator(root: root)
        shortcut()
    }

    private func shortcut() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let info = VisaRequestParams()
            info.no_of_adult = "5"
            info.country_id = "1"
            info.form_type = "gb"
            info.no_of_child = "0"
            info.countryName = "امريكا"
            info.no_of_passport = "3"
            info.relation_with_travelers = RelationIDS.friends.rawValue
            try? AppNavigator().push(.sponsersInfoScreen(info))
        }
    }
}
