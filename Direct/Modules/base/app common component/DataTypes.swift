//
//  DataTypes.swift
//  Direct
//
//  Created by abuzeid on 5/31/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
extension Int{
    var stringValue:String{
        return String(self)
    }
}
extension Double{
    var stringValue:String{
        return String(self)
    }
}
extension String{
    var attributedText:NSAttributedString?{
        let htmlData = self.data(using: String.Encoding.unicode)
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType:
            NSAttributedString.DocumentType.html]
        let attributedString = try? NSMutableAttributedString(data: htmlData ?? Data(),
                                                              options: options,
                                                              documentAttributes: nil)
return attributedString
    }
}
