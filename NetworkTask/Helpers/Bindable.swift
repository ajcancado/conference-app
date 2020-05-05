//
//  Bindable.swift
//  NetworkTask
//
//  Created by Arthur Junqueira Cançado on 04/05/20.
//  Copyright © 2020 Devskiller. All rights reserved.
//

class Bindable<T> {

    typealias Listener = ((T) -> Void)

    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(_ listener: Listener?) {
        self.listener = listener
    }

    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }

}
