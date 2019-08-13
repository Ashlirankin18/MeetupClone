//
//  DocumentsDirectory.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/13/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// Handles documents directory entry methods.
final class DataPersistenceManager {
    
    /// Provides a URL to the documents directory
    ///
    /// - Returns: The path returned
    func documentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    /// Creates a filepath to the documents directory
    ///
    /// - Parameter filename: The name of the plist file that will be saved.
    /// - Returns: A URL Representing the location of the data stored
    func filepathToDocumentsDiretory(filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
    }
}
