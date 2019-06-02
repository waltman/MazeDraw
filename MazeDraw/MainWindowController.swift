//
//  MainWindowController.swift
//  MazeDraw
//
//  Created by Walter Mankowski on 5/29/19.
//  Copyright © 2019 Walter Mankowski. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    @IBOutlet weak var rowsField: NSTextField!
    @IBOutlet weak var colsField: NSTextField!
    @IBOutlet weak var mazeDrawView: MazeDrawView!
    @IBOutlet weak var mazeAlgorithm: NSPopUpButton!
    @IBOutlet weak var solveButton: NSButton!

    override var windowNibName: String {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    @IBAction func redrawMaze(sender: AnyObject) {
        if let rows = Int(rowsField.stringValue) {
            mazeDrawView.rows = rows
        } else {
            mazeDrawView.rows = 0
        }
        if let cols = Int(colsField.stringValue) {
            mazeDrawView.cols = cols
        } else {
            mazeDrawView.cols = 0
        }

        if mazeDrawView.rows > 0 && mazeDrawView.cols > 0 {
            let grid = Grid(rows: mazeDrawView.rows, cols: mazeDrawView.cols)
            switch (mazeAlgorithm.indexOfSelectedItem) {
            case 0:
                Binary_Tree.create(on: grid)
            case 1:
                Sidewinder.create(on: grid)
            case 2:
                Aldous_Broder.create(on: grid)
            case 3:
                Recursive_Backtracker.create(on: grid)
            default:
                print("Unexpected algorithm index = \(mazeAlgorithm.indexOfSelectedItem)")
            }
            var start = grid.cell_at(row: 0, col: 0)!
            var distances = start.distances()
            var maxInfo = distances.max()
            let goal = maxInfo.cell
            distances = maxInfo.cell.distances()
            maxInfo = distances.max()
            start = maxInfo.cell

            grid.startCell = start
            grid.goalCell = goal
            grid.distances = distances
            solveButton.isEnabled = true

            mazeDrawView.grid = grid
            mazeDrawView.path.removeAll()
            mazeDrawView.needsDisplay = true
        } else {
            mazeDrawView = nil
        }
    }

    @IBAction func solveMaze(sender: AnyObject) {
        guard let grid = mazeDrawView.grid else { return }
        guard let distances = grid.distances else { return }
        mazeDrawView.path = distances.path_to(goal: grid.startCell!)
        mazeDrawView.needsDisplay = true
        solveButton.isEnabled = false
    }

}
