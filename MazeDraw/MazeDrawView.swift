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
    let border: CGFloat = 5
    var grid: Grid?
    var path: [Cell] = []
    var width: CGFloat { return (bounds.width - 2 * border) / CGFloat(cols) }
    var height: CGFloat { return (bounds.height - 2 * border) / CGFloat(rows) }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        let bgColor = NSColor.windowBackgroundColor
        bgColor.set()
        NSBezierPath.fill(bounds)
        
        if rows >= 2 && cols >= 2 {
            drawMaze(bounds.size)
            if !path.isEmpty {
                drawPath(bounds.size)
            }
        }
    }
    
    func drawMaze(_ size: NSSize) {
        NSColor.textColor.set()
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
        
        // draw circles at the start and end
        if let g = grid {
            if let start = g.startCell {
                drawDot(at: start, color: NSColor.systemGreen)
            }
            if let goal = g.goalCell {
                drawDot(at: goal, color: NSColor.systemRed)
            }
        }
    }

    func drawPath(_ size: NSSize) {
        NSColor.red.set()
        let bez = NSBezierPath()
        bez.lineWidth = min(width, height) / 4

        let cell = path[0]
        let x = CGFloat(cell.col) * width + border + width/2
        let y = CGFloat(cell.row) * height + border + height/2
        bez.move(to:(NSPoint(x: x, y: y)))
        for cell in path[1...] {
            let x = CGFloat(cell.col) * width + border + width/2
            let y = CGFloat(cell.row) * height + border + height/2
            bez.line(to:(NSPoint(x: x, y: y)))
        }
        bez.stroke()
    }
    
    // draw a colored circle at cell's spot, filling the smaller of the
    // horizontal or vertical dimension
    func drawDot(at cell: Cell, color: NSColor) {
        // determine whitespace around circle
        let b: CGFloat
        if min(width, height) > 2 {
            b = 2
        } else {
            b = 0
        }
        
        // get (x,y) coordinates of bottom corner of cell
        let x = CGFloat(cell.col) * width + border
        let y = CGFloat(cell.row) * height + border
        
        // compute the bounding rectangle
        var rect: CGRect
        if width < height {
            let offset = (height - width) / 2
            rect = CGRect(x: x+b, y: y+offset+b, width: width-b*2, height: width-b*2)
        } else {
            let offset = (width - height) / 2
            rect = CGRect(x: x+offset+b, y: y+b, width: height-b*2, height: height-b*2)
        }
        
        // draw the circle
        color.set()
        let bez = NSBezierPath(ovalIn: rect)
        bez.fill()
        bez.stroke()
    }
}
