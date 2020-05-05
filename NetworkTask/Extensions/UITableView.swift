//
//  UITableView.swift
//  NetworkTask
//
//  Created by Arthur Junqueira Cançado on 05/05/20.
//  Copyright © 2020 Devskiller. All rights reserved.
//

import UIKit

extension UITableView {

    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }

    func register<T: UITableViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }

    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }

    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className) as! T
    }
    
}
