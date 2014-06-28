//
//  MainWindowController.swift
//  SwiftLife
//
//  Created by Adam Preble on 6/27/14.
//  Copyright (c) 2014 Adam Preble. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

	@IBOutlet var gameView: GameOfLifeView
	var tickTimer: NSTimer?
	
	var tickRate: Int = 0 {
		didSet {
			if tickTimer != nil {
				tickTimer!.invalidate()
			}
			if tickRate > 0 {
				let interval:NSTimeInterval = 10.0/Double(tickRate)
				tickTimer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: Selector("timerTick:"), userInfo: nil, repeats: true)
			}
		}
	}

    init() {
        super.init(window: nil)
    }

    override func windowDidLoad() {
        super.windowDidLoad()

		let game = GameOfLife(size: CGSizeMake(20, 20))
		gameView.game = game
    }
	
	func windowNibName() -> String {
		return "MainWindowController"
	}
	
	func timerTick(sender: AnyObject) {
		step(nil)
	}
	
	@IBAction func step(sender: AnyObject?) {
		gameView.game!.tick()
		gameView.needsDisplay = true
	}
    
}
