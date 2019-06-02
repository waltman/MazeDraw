//
//  Grid.swift
//  MazeDraw
//
//  Created by Walter Mankowski on 5/30/19.
//  Copyright © 2019 Walter Mankowski. All rights reserved.
//

import Foundation

class Grid {
    var rows: Int
    var cols: Int
    var grid = [[Cell]]()
    var count: Int { return rows * cols }
    var startCell: Cell?
    var goalCell: Cell?
    var distances: Distances?
    var path: [Cell]?
    
    init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        
        _prepare_grid()
        _configure_cells()
    }
    
    func cell_at(row: Int, col: Int) -> Cell? {
        if row < 0 || row >= rows {
            return nil
        } else if col < 0 || col >= cols {
            return nil
        } else {
            return grid[row][col]
        }
    }
    
    func _prepare_grid() {
        for r in 0..<rows {
            var row = [Cell]()
            for c in 0..<cols {
                row.append(Cell(row: r, col: c))
            }
            grid.append(row)
        }
    }
    
    func _configure_cells() {
        for row in grid {
            for cell in row {
                let row = cell.row
                let col = cell.col
                
                cell.north = cell_at(row: row+1, col: col)
                cell.south = cell_at(row: row-1, col: col)
                cell.west = cell_at(row: row, col: col-1)
                cell.east = cell_at(row: row, col: col+1)
            }
        }
    }
    
    func random_cell() -> Cell {
        let row = Int.random(in: 0..<rows)
        let col = Int.random(in: 0..<cols)
        return cell_at(row: row, col: col)!
    }
}
