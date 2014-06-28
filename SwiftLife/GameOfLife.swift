//
//  GameOfLife.swift
//  SwiftLife
//
//  Created by Adam Preble on 6/25/14.
//  Copyright (c) 2014 Adam Preble. All rights reserved.
//

import Foundation

class GameOfLife: NSObject {

	var board: GameBoard<Bool>

	init(size: CGSize) {
		let gameBoardSize = Size(width: Int(size.width), height: Int(size.height))
		board = GameBoard<Bool>(size:gameBoardSize, initialValue:false)
	}

	func tick() {
		rewriteBoard() {
			live, neighbors in
			switch (live, neighbors) {
			case (true, 0...1):
				return false // under-population
			case (true, 2...3):
				return true // lives
			case (true, 4...6):
				return false // overcrowding
			case (false, 3):
				return true // reproduction
			default:
				return live
			}
		}
	}
	
	func rewriteBoard(closure: (live: Bool, neighbors: Int) -> Bool) {
		var copy = GameBoard<Bool>(boardToCopy: board)
		board.enumerateUsingClosure() {
			position, live in
			
			let numLiveNeighbors = self.numberOfLiveNeihgborsToPosition(position)
			let stillLive = closure(live: live, neighbors: numLiveNeighbors)
			copy.setValue(stillLive, position: position)
		}
		board = copy
	}
	
	func numberOfLiveNeihgborsToPosition(position: Point) -> Int {
		return board.numberOfNeighborsOfPosition(position, equalToValue: true)
	}
}

