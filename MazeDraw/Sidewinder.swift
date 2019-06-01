//
//  Sidewinder.swift
//  MazeDraw
//
//  Created by Walter Mankowski on 5/31/19.
//  Copyright © 2019 Walter Mankowski. All rights reserved.
//

import Foundation

class Sidewinder {
    static func create(on grid: Grid) {
        for row in grid.grid {
            var run = [Cell]()
            for cell in row {
                run.append(cell)
                
                let at_east_bdry = cell.east == nil
                let at_north_bdry = cell.north == nil
                let should_close_out = at_east_bdry || (!at_north_bdry && Int.random(in: 0...1) == 0)
                
                if should_close_out {
                    let member = run.randomElement()!
                    if member.north != nil {
                        member.link(cell: member.north!)
                    }
                    run.removeAll()
                } else {
                    cell.link(cell: cell.east!)
                }
            }
        }
    }
}
