//
//  String+Extension.swift
//  Kingfisher
//
//  Created by Ashli Rankin on 8/7/19.
//

import Foundation

extension String {
    func convertHTMLStrings() -> NSAttributedString? {
        if let data = self.data(using: .utf8),
            let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil){
            return attributedString
        }
        return NSAttributedString()
    }
}
