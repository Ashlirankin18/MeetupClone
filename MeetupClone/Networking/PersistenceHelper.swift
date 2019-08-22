//
//  PersistenceHelper.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/13/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// The class represents the method for interacting with the Documents Directory
final class PersistenceHelper {
    private init () {}
    
    /// The instance of the `PersistenceHelper` class that will be shared 
    static let shared = PersistenceHelper()
    
    private let fileName = "newFavoriteEvents.plist"
    
    private(set) lazy var favoriteEvents: [MeetupEventModel] = retrieveFavoriteEventsFromDocumentsDirectory()
    
    /// Retrieves an array of the MeetupEventModel type from the documents directory
    ///
    /// - Returns: An array of MeetupEventModel
    private func retrieveFavoriteEventsFromDocumentsDirectory() -> [MeetupEventModel] {
        if let path = DataPersistenceManager().filepathToDocumentsDiretory(filename: fileName)?.path {
            if FileManager.default.fileExists(atPath: path),
                let data = FileManager.default.contents(atPath: path) {
                do {
                    favoriteEvents = try PropertyListDecoder().decode([MeetupEventModel].self, from: data)
                } catch {
                    assertionFailure("could not decode favorite events from data")
                }
            } else {
                print("\(fileName) does not exist")
            }
        } else {
            print("No path was found")
        }
        return favoriteEvents
    }
    /// Saves objects added of removed from the documents directory
    func saveFavoriteEventsToDocumentsDirectory() {
        if let path = DataPersistenceManager().filepathToDocumentsDiretory(filename: fileName) {
            
            do {
                let data = try PropertyListEncoder().encode(favoriteEvents)
                try data.write(to: path, options: .atomic)
            } catch {
                assertionFailure("Could not encode data")
            }
        }
    }
    /// Adds the event the user has favorited to the documents directory.
    ///
    /// - Parameter favoriteEvent: The event that was chosen by the user.
    func addFavoriteEventToDocumentsDirectory(favoriteEvent: MeetupEventModel) {
        favoriteEvents.append(favoriteEvent)
        saveFavoriteEventsToDocumentsDirectory()
    }
    
    /// Removes an event from the documents directory
    ///
    /// - Parameter favoriteEvent: The event which was chosen by the user to delete
    func deleteItemFromDocumentsDirectory(favoriteEvent: MeetupEventModel) {
        if let index = favoriteEvents.firstIndex(where: { $0.eventId == favoriteEvent.eventId }) {
            favoriteEvents.remove(at: index)
            saveFavoriteEventsToDocumentsDirectory()
        } else {
            assertionFailure("Index could not be found")
        }
    }
    
    /// Chacks the favorites Array for the chosen eventId
    ///
    /// - Parameter eventId: The chosen event array
    /// - Returns: Returns wether the event id is contained
    func isEventFavorited(eventId: String) -> Bool {
        return favoriteEvents.contains(where: { $0.eventId == eventId })
    }
}
