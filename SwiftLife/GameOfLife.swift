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
		// Naive way to do this would be to check the neighbors of each cell.
		// This ends up doing a lot of checking that's unnecessary. Instead,
		// we'll construct a table containing the counts of the neighbors for
		// each cell which will allow us to avoid all of that duplicated work.
		var neighborBoard = GameBoard<Int>(size: board.size, initialValue: 0)
		board.enumerateUsingClosure() {
			position, live in
			
			if live {
				self.board.enumerateNeighborsOfPosition(position) {
					neighborPosition, _ in
					let count = neighborBoard.valueAtPosition(neighborPosition)
					neighborBoard.setValue(count! + 1, position: neighborPosition)
				}
			}
		}
		board.mutateUsingClosure() {
			position, live in
			
			let numLiveNeighbors = neighborBoard.valueAtPosition(position)
			let stillLive = closure(live: live, neighbors: numLiveNeighbors!)
			return stillLive
		}
	}
	
	func numberOfLiveNeihgborsToPosition(position: Point) -> Int {
		return board.numberOfNeighborsOfPosition(position, equalToValue: true)
	}
}

