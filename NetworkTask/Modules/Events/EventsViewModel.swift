//
//  EventsViewModel.swift
//  NetworkTask
//
//  Created by Arthur Junqueira Cançado on 05/05/20.
//  Copyright © 2020 Devskiller. All rights reserved.
//

import UIKit

class EventsViewModel {
    
    var title: String { return Constants.APP.events }
    
    var showAlertController: Bindable = Bindable(UIAlertController())
    var reloadTableView: Bindable = Bindable(true)
    var showActivityIndicator: Bindable = Bindable(true)
    var hideActivityIndicator: Bindable = Bindable(true)
    
    var eventResponse: EventResponse?
    
    func handleEvents() {
        
        showActivityIndicator.value = true
        
        NetworkService.sharedService.getAllEvents(success: { data in
            self.hideActivityIndicator.value = true
            self.eventResponse = data
        }) { error in
            self.hideActivityIndicator.value = true
        }
    }
    
    func handleSubscribeOnEvent(event: Event) {
        
        let alertController = UIAlertController(title: Constants.Messages.subscribeQuestion,
                                                message: event.name,
                                                preferredStyle: UIAlertController.Style.alert)

        let cancelAction = UIAlertAction(title: Constants.Messages.no, style: UIAlertAction.Style.cancel)
        
        let subscribeAction = UIAlertAction(title: Constants.Messages.yes, style: UIAlertAction.Style.default ) { _ in
            self.makeSubscribeOnEvent(eventUUID: event.uuid)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(subscribeAction)
        
        showAlertController.value = alertController
    }
    
    func makeSubscribeOnEvent(eventUUID: Int) {
        
        showActivityIndicator.value = true
        
        NetworkService.sharedService.subscribeOnEvent(eventUUID: eventUUID, success: { response in
        
            SessionManager.shared.userResponse = response
            
            self.hideActivityIndicator.value = true
            
            self.reloadTableView.value = true
            
        }, failure: { error in
            self.hideActivityIndicator.value = true
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let events = eventResponse?.events.count else { return 0 }
        
        return events
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(with: EventCell.self, for: indexPath)
        
        if let event = eventResponse?.events[indexPath.row] {
            cell.nameLabel.text = event.name
            cell.alreadySubscribeView.isHidden = !SessionManager.shared.alreadySubscribeOnEvent(eventUUID: event.uuid)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let event = eventResponse?.events[indexPath.row] else { return }
        
        if !SessionManager.shared.alreadySubscribeOnEvent(eventUUID: event.uuid) {
            handleSubscribeOnEvent(event: event)
        }
    }

}
