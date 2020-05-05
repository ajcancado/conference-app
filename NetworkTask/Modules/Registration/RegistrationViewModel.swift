//
//  HomeViewModel.swift
//  NetworkTask
//
//  Created by Arthur Junqueira Cançado on 04/05/20.
//  Copyright © 2020 Devskiller. All rights reserved.
//

import UIKit

protocol RegistrationViewModelProtocol {
    func registerUserWith(login: String?, password: String?)
}

class RegistrationViewModel: RegistrationViewModelProtocol {
    
    var goToEventsViewController: Bindable = Bindable(true)

    func registerUserWith(login: String?, password: String?) {
        
        NetworkService.sharedService.registerUserWith(login: login, password: password, success: { (succes) in
            
            self.goToEventsViewController.value = true
            
        }) { (error) in
            
        }
        
    }
    
}
