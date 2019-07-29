//
//  GroupDisplayViewController.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/23/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// Display a list of groups that the user searches for.
class GroupDisplayViewController: UIViewController {
    
    private let meetUpDataHandler = MeetupDataHandler(networkHelper: NetworkHelper())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveGroups()
    }
    
    private func retrieveGroups(){
        meetUpDataHandler.retrieveMeetupGroups(zipCode: 11429) { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let groups):
                print(groups)
            }
        }
    }
}
