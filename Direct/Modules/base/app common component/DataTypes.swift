//
//  DataTypes.swift
//  Direct
//
//  Created by abuzeid on 5/31/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import UIKit

extension Int {
    var stringValue: String {
        return String(self)
    }
}

extension Double {
    var stringValue: String {
        return String(self)
    }
}

extension String {
    var attributedText: NSAttributedString? {
        let htmlData = data(using: String.Encoding.unicode)
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [NSAttributedString.DocumentReadingOptionKey.documentType:
            NSAttributedString.DocumentType.html]
        
        let options2 = [NSAttributedString.Key.font: UIFont(name: AppFonts.regularFont, size: 12.0)!]
        let attributedString = try? NSMutableAttributedString(data: htmlData ?? Data(),
                                                              options: options,
                                                              documentAttributes: nil)
        return attributedString
    }
    
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

