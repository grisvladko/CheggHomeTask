//
//  JSONAccessPath.swift
//  ios-sources-assignment
//
//  Created by hyperactive on 26/05/2021.
//  Copyright © 2021 Chegg. All rights reserved.
//

import Foundation

/*
 This path serves as a linked list to the exact pool of objects we are looking for.
 any number of keys can be given to access a particular element pool in a chained order,
 just plug in your keys into an array and adjust the datasource.
 
 */

class JSONAccessPath {
    
    var root: Node?
    var source: Constants.Datasource
    
    private let pathToElementA = ["stories"]
    private let pathToElementB = ["metadata","innerdata"]
    private let pathToElementC : [AnyHashable] = []

    init(source: Constants.Datasource) {
        self.source = source
        
        switch source {
            case .sourceA : makePath(pathToElementA)
            case .sourceB : makePath(pathToElementB)
            case .sourceC : makePath(pathToElementC)
        }
    }
    
    private func makePath(_ path: [AnyHashable]) {
        for element in path {
            if root == nil {
                root = Node(key: element)
            } else {
                root?.next = Node(key: element)
            }
        }
    }
}

class Node {
    var next: Node?
    let key: AnyHashable
    
    init(key: AnyHashable) {
        self.key = key
    }
}
