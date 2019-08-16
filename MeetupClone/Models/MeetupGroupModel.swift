//
//  MeetupGroupModel.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/22/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// Represents a MeetupGroup model.
struct MeetupGroupModel: Codable {
    
    /// Meetup group Id
    let id: Int
    
    /// The name of the group
    let groupName: String
    
    /// The group's urlName which will be used to search for groupd events,Rsvp etc
    let urlName: String
    
    /// The link to the group's website
    let link: URL?
    
    /// The date group was created
    let createdDate: Date
    
    /// The group image
    let groupPhoto: MeetupPhotoModel?
    
    /// The next event the group will host
    let nextEvent: MeetupNextEventModel?
    
    /// The group's description
    let description: String
    
    /// The number of people who are members of the group.
    let members: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case groupName = "name"
        case link
        case description
        case urlName = "urlname"
        case createdDate = "created"
        case groupPhoto = "group_photo"
        case nextEvent = "next_event"
        case members
    }   
}
