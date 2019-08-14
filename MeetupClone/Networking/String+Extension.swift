//
//  String+Extension.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/7/19.
//

import Foundation

// MARK: - Extension to the String class
extension String {
    
    /// Will convert a String with possible HTML syntax to a human readable format
    ///
    /// - Returns: An string which will display in an human readable format.
    /// - Throws: This function will throw an error if an attribute string could not be created
    func asHTMLAttributedString() throws -> NSAttributedString {
        if let data = self.data(using: .utf8),
            let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            return attributedString
        }
        return NSAttributedString()
    }
}
