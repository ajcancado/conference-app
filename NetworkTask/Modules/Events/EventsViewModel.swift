//
//  EventsViewModel.swift
//  NetworkTask
//
//  Created by Arthur Junqueira Cançado on 05/05/20.
//  Copyright © 2020 Devskiller. All rights reserved.
//

import UIKit

protocol EventsViewModelProtocol {
    
}

class EventsViewModel: EventsViewModelProtocol {
    
    var reloadTableView: Bindable = Bindable(true)
    
    var eventResponse: EventResponse?
    
    func handleEvents() {
        
        NetworkService.sharedService.getAllEvents(success: { data in
            self.eventResponse = data
        }) { error in
           
        }

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let events = eventResponse?.events.count else { return 0 }
        
        return events
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(with: EventCell.self, for: indexPath)
        
        cell.nameLabel.text = eventResponse?.events[indexPath.row].name ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let uuid = eventResponse?.events[indexPath.row].uuid else { return }
        
        NetworkService.sharedService.subscribeOnEvent(eventUUID: uuid, success: { response in
        
        }, failure: { error in
            
        })
        
        
    }

}
