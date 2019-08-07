//
//  EventsDisplayTableViewControllerDataSource.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/1/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

class EventsDisplayTableViewControllerDataSource: NSObject, UITableViewDataSource {
    
    //NOTE this will be changed to even once the network Login Pull Request becomes approved
    var items = [MeetupEventModel]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventDisplayCell", for: indexPath) as? EventDisplayTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}
