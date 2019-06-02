//
//  Distances.swift
//  MazeDraw
//
//  Created by Walter Mankowski on 6/1/19.
//  Copyright © 2019 Walter Mankowski. All rights reserved.
//

import Foundation

class Distances {
    var root: Cell
    var distance_to: [Cell: Int]

    init(root: Cell) {
        self.root = root
        distance_to = [root: 0]
    }

    func path_to(goal: Cell) -> [Cell] {
        var current = goal
        let breadcrumbs = Distances(root: root)
        var path: [Cell] = [current]
        breadcrumbs.distance_to[current] = distance_to[current]

        while current != root {
            for neighbor in current.links {
                if distance_to[neighbor]! < distance_to[current]! {
                    breadcrumbs.distance_to[neighbor] = distance_to[neighbor]
                    current = neighbor
                    path.append(current)
                }
            }
        }
        return path
    }

    func max() -> (cell: Cell, dist: Int) {
        var max_dist = 0
        var max_cell = root

        for (cell, dist) in distance_to {
            if dist > max_dist {
                max_dist = dist
                max_cell = cell
            }
        }
        return (max_cell, max_dist)
    }
}
