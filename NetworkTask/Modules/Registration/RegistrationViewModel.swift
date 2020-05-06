//
//  HomeViewModel.swift
//  NetworkTask
//
//  Created by Arthur Junqueira Cançado on 04/05/20.
//  Copyright © 2020 Devskiller. All rights reserved.
//

import UIKit

class RegistrationViewModel {
    
    var title: String {
        return Constants.APP.name
    }
    
    var description: String {
        return Constants.Messages.registerDiscription
    }
    
    var showAlertController: Bindable = Bindable(UIAlertController())
    var showActivityIndicator: Bindable = Bindable(true)
    var hideActivityIndicator: Bindable = Bindable(true)
    var goToEventsViewController: Bindable = Bindable(true)

    func handleUserRegistration(login: String?, password: String?){
        
        guard let login = login,
            let password = password else {
                showErrorAlert()
                return
        }
        
        if login.isEmpty || password.isEmpty {
            showErrorAlert()
            return
        }
        
        makeRegisterUserWith(login: login, password: password)
    }
    
    private func showErrorAlert() {
        
        let alertController = UIAlertController(title: Constants.APP.name,
                                                message: Constants.Messages.registerError,
                                                preferredStyle: UIAlertController.Style.alert)

        let okAction = UIAlertAction(title: Constants.Messages.ok, style: UIAlertAction.Style.destructive)
        
        alertController.addAction(okAction)
        
        showAlertController.value = alertController
    }
    
    private func makeRegisterUserWith(login: String, password: String) {
        
        showActivityIndicator.value = true
        
        NetworkService.sharedService.registerUserWith(login: login, password: password, success: { (userResponse) in
            
            SessionManager.shared.userResponse = userResponse
            
            self.hideActivityIndicator.value = true
            self.goToEventsViewController.value = true
            
        }) { (error) in
            
            self.hideActivityIndicator.value = true
        }
        
    }
    
}
