//
//  AppDelegate.swift
//  Direct
//
//  Created by abuzeid on 4/24/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import IQKeyboardManagerSwift
import UIKit
import LanguageManager_iOS

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navigator: Navigator!
    static var current: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let newLang = AppLanguage.langCode == "ar" ? Languages.ar : Languages.en

//        LanguageManager.shared.defaultLanguage = Languages.ar
        L102Localizer.DoTheMagic()
        setRootController()
        setupGlobalAppearance()
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


    func setupGlobalAppearance() {
        window?.tintColor = UIColor.white
        // global Appearance settings
        let customFont = UIFont.appRegularFontWith(size: 15)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: customFont], for: .normal)
        UITextField.appearance().substituteFontName = AppFonts.regularFont
        UILabel.appearance().substituteFontName = AppFonts.regularFont
//        UILabel.appearance().substituteFontNameBold = AppFonts.boldFont

//        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont(name: AppFonts.regularFont, size: 11)!,
                                                          .foregroundColor: UIColor.gray], for: .normal)
    }

    func setRootController() {
        let root = UIStoryboard.main.instantiateViewController(withIdentifier: StoryBoardIds.rootController.id) as! RootNavigationViewController
        window?.rootViewController = root
        window?.makeKeyAndVisible()
        navigator = AppNavigator(root: root)
//       shortcut()
    }

    private func shortcut() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let info = VisaRequestParams()
            info.no_of_adult = "1"
            info.country_id = "1"
            info.userid = User.shared.id
            info.form_type = "us"
            info.no_of_child = "0"
            info.countryName = "امريكا"
            info.no_of_passport = "1"
            info.relation_with_travelers = RelationIDS.family.rawValue
            try? AppNavigator().push(Destination.confirmatonVisa(info, reqID: "66"))
        }
    }

    /// Payfort
    func applicationDidEnterBackground(_ application: UIApplication) {
        var bgTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier(rawValue: 0)
        bgTask = application.beginBackgroundTask(expirationHandler: {
            application.endBackgroundTask(bgTask)
            bgTask = UIBackgroundTaskIdentifier.invalid
        })
    }
}
