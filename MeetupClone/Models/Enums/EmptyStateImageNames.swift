//
//  EmptyStateImageNames.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/15/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// The names of the image assests that relate to emptyState
///
/// - notAMemberofGroup: The user is not a member of the group
/// - noEventsFound: No events were returned for the qurey
/// - noFavoritesFound: The user has no save events
/// - noGroupFound: No groups were from the qurey
enum EmptyStateImageName: String {
    case notAMemberofGroup = "notAMember"
    case noEventsFound = "noEvents"
    case noFavoritesFound = "noFavorite"
    case noGroupFound = "noGroups"
}
