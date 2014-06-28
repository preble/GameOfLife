//
//  GameOfLifeView.swift
//  SwiftLife
//
//  Created by Adam Preble on 6/25/14.
//  Copyright (c) 2014 Adam Preble. All rights reserved.
//

import Cocoa

class GameOfLifeView: NSView {

	var game: GameOfLife?
	
    init(frame: NSRect) {
        super.init(frame: frame)
        // Initialization code here.
    }

	func isFlipped() -> Bool {
		return true
	}
	
	var xInc: Int {
		assert(game != nil, "game must be set")
		return Int(NSWidth(bounds)/CGFloat(game!.board.size.width))
	}
	var yInc: Int {
		assert(game != nil, "game must be set")
		return Int(NSHeight(bounds)/CGFloat(game!.board.size.height))
	}
	
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
		
		NSColor.whiteColor().set()
		NSRectFill(bounds)
		
		if let game = game {
			NSColor.blackColor().set()
			
			let (xInc, yInc) = (self.xInc, self.yInc)
			
			game.board.enumerateUsingClosure() {
				position, live in
				
				if live {
					let rect = CGRect(x:position.x * xInc, y:position.y * yInc, width:xInc, height:yInc)
					NSRectFill(rect)
				}
			}
		}
    }
	
	override func mouseUp(theEvent: NSEvent!) {
		let pointInView = convertPoint(theEvent.locationInWindow, fromView: nil)
		let logicalPosition = Point(x: Int(pointInView.x) / xInc, y: Int(pointInView.y) / yInc)
		
		if let game = game {
			if let live = game.board.valueAtPosition(logicalPosition) {
				println("Toggling \(logicalPosition.x), \(logicalPosition.y)")
				game.board.setValue(!live, position: logicalPosition)
				needsDisplay = true
			} // else it was not a valid position
		}
	}
    
}
