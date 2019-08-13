//
//  PersistenceHelper.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/13/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

final class PersistenceHelper {
    private let fileName = "FavoriteEvents.plist"
    
    typealias FavoriteEvents = EventDetailedTableViewController.ViewModel
    
    private var favoriteEvents = [FavoriteEvents]()
    
    /// Retrieves an array of the FavoriteEvents type from the documents directory
    ///
    /// - Returns: An array of FavoriteEvents
    func retrieveFavoriteEventsFromDocumentsDirectory() -> [EventDetailedTableViewController.ViewModel] {
        let path = DataPersistenceManager().filepathToDocumentsDiretory(filename: fileName).path
        if FileManager.default.fileExists(atPath: path),
            let data = FileManager.default.contents(atPath: path) {
            do {
                favoriteEvents = try PropertyListDecoder().decode([FavoriteEvents].self, from: data)
            } catch {
               assertionFailure("could not decode favorite events from data")
            }
        } else {
             assertionFailure("\(fileName) does not exist.")
        }
        
       return favoriteEvents
    }
    
    /// Saves objects added of removed from the documents directory
    func saveFavoriteEventsToDocumentsDirectory() {
        let path = DataPersistenceManager().filepathToDocumentsDiretory(filename: fileName)
        
        do {
            let data = try PropertyListEncoder().encode(favoriteEvents)
            try data.write(to: path, options: .atomic)
        } catch {
            assertionFailure("Could not encode data")
        }
    }
    
    func addFavoriteEventToDocumentsDirectory(favoriteEvent: FavoriteEvents) {
        favoriteEvents.append(favoriteEvent)
        saveFavoriteEventsToDocumentsDirectory()
    }
    
    func deleteItemFromDocumentsDirectory(favoriteEvent: FavoriteEvents) {
        if let index = favoriteEvents.firstIndex(where: { $0.eventId == favoriteEvent.eventId }) {
            favoriteEvents.remove(at: index)
            saveFavoriteEventsToDocumentsDirectory()
        } else {
            assertionFailure("Index could not be found")
        }
    }    
}
