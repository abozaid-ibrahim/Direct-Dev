//
//  LanguageManager.swift
//  Direct
//
//  Created by abuzeid on 7/29/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import LanguageManager_iOS

class AppLanguage {
    static var langCode: String {
        return Locale.preferredLanguages[0].prefix(2) == "ar" ? "ar" : "en"
    }

    static var languages: [LangEntity] {
        return [LangEntity(name: "Arabic".localized(), code: "ar", selected: langCode == "ar"),
                LangEntity(name: "English".localized(), code: "en", selected: langCode == "en")]
    }

    static var currentLangName: String {
        return languages.filter { $0.selected }.first!
            .name
    }

    static func setCurrent(language: String) {
        let newLang = language == "ar" ? Languages.ar : Languages.en
//        UserDefaults.standard.set([language], forKey: "AppleLanguages")
//        UserDefaults.standard.synchronize()
        LanguageManager.shared.setLanguage(language: newLang, rootViewController: nil, animation: nil)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            AppDelegate.current.setRootController()
//        }
//        let root = UIStoryboard.main.instantiateViewController(withIdentifier: StoryBoardIds.rootController.id) as! RootNavigationViewController
//
//        LanguageManager.shared.setLanguage(language: newLang, rootViewController: root, animation: { view in
//            // do custom animation
//            view.transform = CGAffineTransform(scaleX: 2, y: 2)
//            view.alpha = 0
//        })
    }
}

struct LangEntity {
    var name: String
    var code: String
    var selected: Bool
    mutating func did(select: Bool) {
        selected = select
    }
}
