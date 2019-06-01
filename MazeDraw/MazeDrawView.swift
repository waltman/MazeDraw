//
//  MazeDrawView.swift
//  MazeDraw
//
//  Created by Walter Mankowski on 5/29/19.
//  Copyright © 2019 Walter Mankowski. All rights reserved.
//

import Cocoa

class MazeDrawView: NSView {
    var rows:Int = 5
    var cols:Int = 10
    var grid: Grid?

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        let bgColor = NSColor.white
        bgColor.set()
        NSBezierPath.fill(bounds)
        
        if rows >= 2 && cols >= 2 {
            drawMaze(bounds.size)
        }
    }
    
    func drawMaze(_ size: NSSize) {
        let border: CGFloat = 5
        let width = (bounds.width - 2 * border) / CGFloat(cols)
        let height = (bounds.height - 2 * border) / CGFloat(rows)
        
        NSColor.black.set()
        let path = NSBezierPath()
        path.lineWidth = 1
        
        // draw horizontal lines
        for r in 0...rows {
            let y = CGFloat(r) * height + border
            path.move(to:(NSPoint(x: border, y: y)))
            for c in 1...cols {
                let x = CGFloat(c) * width + border
                if grid != nil {
                    let cell = grid!.cell_at(row: r, col: c-1)
                    if cell == nil || !(cell!.is_linked(cell: cell!.south)) {
                        path.line(to:(NSPoint(x: x, y: y)))
                    }
                } else {
                    path.line(to:(NSPoint(x: x, y: y)))
                }
                path.move(to:(NSPoint(x: x, y: y)))
            }
        }
        
        // draw vertical lines
        for c in 0...cols {
            let x = CGFloat(c) * width + border
            path.move(to:(NSPoint(x: x, y: border)))
            for r in 1...rows {
                let y = CGFloat(r) * height + border
                if grid != nil {
                    let cell = grid!.cell_at(row: r-1, col: c)
                    if cell == nil || !(cell!.is_linked(cell: cell!.west)) {
                        path.line(to:(NSPoint(x: x, y: y)))
                    }
                } else {
                    path.line(to:(NSPoint(x: x, y: y)))
                }
                path.move(to:(NSPoint(x: x, y: y)))
            }
        }
        
        path.stroke()
   }
    
}
