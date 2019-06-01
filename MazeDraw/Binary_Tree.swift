//
//  Binary_Tree.swift
//  MazeDraw
//
//  Created by Walter Mankowski on 5/31/19.
//  Copyright © 2019 Walter Mankowski. All rights reserved.
//

import Foundation

class Binary_Tree {
    static func create(on grid: Grid) {
        for row in grid.grid {
            for cell in row {
                var neighbors = [Cell]()
                if cell.north != nil {
                    neighbors.append(cell.north!)
                }
                if cell.east != nil {
                    neighbors.append(cell.east!)
                }
                
                if !neighbors.isEmpty {
                    let idx = Int.random(in: 0..<neighbors.count)
                    let neighbor = neighbors[idx]
                    cell.link(cell: neighbor)
                }
            }
        }
    }
}
