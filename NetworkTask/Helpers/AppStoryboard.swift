//
//  AppStoryboard.swift
//  NetworkTask
//
//  Created by Arthur Junqueira Cançado on 05/05/20.
//  Copyright © 2020 Devskiller. All rights reserved.
//

import UIKit

enum AppStoryboard: String {
    
    case main = "Main"
    
    var instance: UIStoryboard {
        return UIStoryboard(name: rawValue, bundle: Bundle.main)
    }

    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }

    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}
