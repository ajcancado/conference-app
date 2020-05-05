//
//  UIViewController.swift
//  NetworkTask
//
//  Created by Arthur Junqueira Cançado on 05/05/20.
//  Copyright © 2020 Devskiller. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class var storyboardID: String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard: AppStoryboard) -> Self {
        return fromAppStoryboard.viewController(viewControllerClass: self)
    }
}
