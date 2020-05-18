//
//  Binder.swift
//  Worker App
//
//  Created by Aniruddha Kadam on 4/7/19.
//  Copyright © 2019 Ridecell. All rights reserved.
//

import Foundation

// Binder class - used for boxing current data types so it can be bound with closure functions from ViewControllers
class Binder<T> {
    
    typealias ClosureFunction = (T) -> Void
    
    // Closure function
    private var changeInValue: ClosureFunction?
    
    // Closure function call on bound data value change
    var value: T {
        didSet {
            changeInValue?(value)
        }
    }
    
    init(val: T) {
        value = val
    }
    
    func attachAndUpdate(_ closureFunc: ClosureFunction?) {
        changeInValue = closureFunc
        changeInValue?(value)
    }
    
    // Attach closure function to Binder from ViewControllers
    func attachClosureFunction(closureFunc: ClosureFunction?) {
        changeInValue = closureFunc
    }
}
