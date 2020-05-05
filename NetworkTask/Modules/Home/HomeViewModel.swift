//
//  HomeViewModel.swift
//  NetworkTask
//
//  Created by Arthur Junqueira Cançado on 04/05/20.
//  Copyright © 2020 Devskiller. All rights reserved.
//

import UIKit

protocol HomeViewModelProtocol {
    
    func registerUser()
    
}

class HomeViewModel: HomeViewModelProtocol {
    
    var authenticationWithError: Bindable = Bindable(String())

    func registerUser() {
        
        NetworkService.sharedService.registerUserWith(login: "LOGIN", password: "PASS", success: { (succes) in
            
        }) { (error) in
            
        }
        
    }
    
}
