//
//  Aldous_Broder.swift
//  MazeDraw
//
//  Created by Walter Mankowski on 5/31/19.
//  Copyright © 2019 Walter Mankowski. All rights reserved.
//

import Foundation

class Aldous_Broder {
    static func create(on grid: Grid) {
        var cell = grid.random_cell()
        var unvisited = grid.count - 1
        
        while unvisited > 0 {
            guard let neighbor = cell.neighbors().randomElement() else {
                print("found a cell without neighbors!")
                return
            }
            if neighbor.links.isEmpty {
                cell.link(cell: neighbor)
                unvisited -= 1
            }
            cell = neighbor
        }
    }
}
