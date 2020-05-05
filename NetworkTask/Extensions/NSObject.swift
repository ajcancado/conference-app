//
//  NSObject.swift
//  NetworkTask
//
//  Created by Arthur Junqueira Cançado on 05/05/20.
//  Copyright © 2020 Devskiller. All rights reserved.
//

import UIKit

extension NSObject {
    
    static var className: String {
       return String(describing: self)
    }

    var className: String {
       return type(of: self).className
    }
}
