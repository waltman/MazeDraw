//
//  Cell.swift
//  MazeDraw
//
//  Created by Walter Mankowski on 5/30/19.
//  Copyright © 2019 Walter Mankowski. All rights reserved.
//

import Foundation

class Cell: Hashable, Equatable, CustomStringConvertible {
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        return lhs.row == rhs.row && lhs.col == rhs.col
    }
    
    var row: Int
    var col: Int
    var north: Cell?
    var south: Cell?
    var east: Cell?
    var west: Cell?
    var links: Set<Cell>
    
    init(row: Int, col:Int) {
        self.row = row
        self.col = col
        links = Set<Cell>()
    }
    
    public var description: String { return "<\(type(of: self)): row=\(row), col=\(col)>" }

    func hash(into hasher: inout Hasher) {
        hasher.combine(row)
        hasher.combine(col)
    }
    
    func link(cell: Cell, bidi: Bool=true) {
        links.insert(cell)
        if bidi {
            cell.link(cell: self, bidi: false)
        }
    }
    
    func unlink(cell: Cell, bidi: Bool=true) {
        links.remove(cell)
        if bidi {
            cell.unlink(cell: self, bidi: false)
        }
    }
    
    func is_linked(cell: Cell?) -> Bool {
        return cell != nil && links.contains(cell!)
    }
    
    func neighbors() -> [Cell] {
        var n: [Cell] = []
        for x in [north, south, east, west] {
            if let y = x {
                n.append(y)
            }
        }
        return n
    }

    func distances() -> Distances {
        let distances = Distances(root: self)
        var q = [self]
        var idx = 0

        while idx < q.count {
            let cell = q[idx]
            idx += 1
            for linked in cell.links {
                if distances.distance_to[linked] == nil {
                    distances.distance_to[linked] = distances.distance_to[cell]! + 1
                    q.append(linked)
                }
            }
        }
        return distances
    }
}
