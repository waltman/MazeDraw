//
//  Recursive_Backtracker.swift
//  MazeDraw
//
//  Created by Walter Mankowski on 5/31/19.
//  Copyright © 2019 Walter Mankowski. All rights reserved.
//

import Foundation

class Recursive_Backtracker {
    static func create(on grid: Grid) {
        var stack: [Cell] = [grid.random_cell()]
        
        while !stack.isEmpty {
            let current = stack.last!
            var neighbors = [Cell]()
            for n in current.neighbors() {
                if n.links.isEmpty {
                    neighbors.append(n)
                }
            }
            
            if !neighbors.isEmpty {
                let neighbor = neighbors.randomElement()!
                current.link(cell: neighbor)
                stack.append(neighbor)
            } else {
                _ = stack.popLast()
            }
        }
    }
}
