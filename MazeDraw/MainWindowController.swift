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
            mazeDrawView.grid = grid
            mazeDrawView.needsDisplay = true
        } else {
            mazeDrawView = nil
        }
        
    }
}
