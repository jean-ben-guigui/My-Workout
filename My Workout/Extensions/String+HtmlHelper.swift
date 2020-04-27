//
//  String+HtmlHelper.swift
//  My Workout
//
//  Created by Arthur Duver on 26/04/2020.
//  Copyright © 2020 Arthur Duver. All rights reserved.
//

import Foundation
import UIKit

/// Allows to parse a html string and return an attributedString with the font UIFont.TextStyle.body
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            let string = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
                string.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.label, NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)], range: NSRange(location: 0, length: string.length))
            return string
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
