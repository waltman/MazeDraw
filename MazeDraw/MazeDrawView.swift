//
//  MazeDrawView.swift
//  MazeDraw
//
//  Created by Walter Mankowski on 5/29/19.
//  Copyright © 2019 Walter Mankowski. All rights reserved.
//

import Cocoa

class MazeDrawView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        let bgColor = NSColor.white
        bgColor.set()
        NSBezierPath.fill(bounds)
        
        drawMaze(bounds.size)
    }
    
    func drawMaze(_ size: NSSize) {
        let rows = 5
        let cols = 10
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
            for c in 0...cols {
                let x = CGFloat(c) * width + border
                path.line(to:(NSPoint(x: x, y: y)))
                path.move(to:(NSPoint(x: x, y: y)))
            }
        }
        
        // draw vertical lines
        for c in 0...cols {
            let x = CGFloat(c) * width + border
            path.move(to:(NSPoint(x: x, y: border)))
            for r in 0...rows {
                let y = CGFloat(r) * height + border
                path.line(to:(NSPoint(x: x, y: y)))
                path.move(to:(NSPoint(x: x, y: y)))
            }
        }
        
        path.stroke()
   }
    
}
