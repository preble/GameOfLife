//
//  GameBoard.swift
//  SwiftLife
//
//  Created by Adam Preble on 6/27/14.
//  Copyright (c) 2014 Adam Preble. All rights reserved.
//

import Foundation



struct Size {
	var width: Int
	var height: Int
}
struct Point {
	var x: Int
	var y: Int
}

class GameBoard<T:Equatable> {
	
	let size: Size
	var data: Array<T>;
	
	init(size: Size, initialValue: T) {
		self.size = size
		self.data = Array<T>(count: Int(self.size.width * self.size.height), repeatedValue: initialValue)
	}
	
	init(boardToCopy: GameBoard<T>) {
		self.size = boardToCopy.size
		self.data = boardToCopy.data.copy()
	}
	
	func dataIndexForPosition(position: Point) -> Int {
		return position.y * size.width + position.x
	}
	
	func setValue(value: T, position: Point) {
		data[dataIndexForPosition(position)] = value
	}
	func valueAtPosition(position: Point) -> T? {
		if position.x < 0 || position.y < 0 || position.x >= size.width || position.y >= size.height {
			return nil
		}
		return data[dataIndexForPosition(position)]
	}
	func enumerateUsingClosure(closure: (position: Point, value: T) -> Void) {
		for x in 0..size.width {
			for y in 0..size.height {
				let position = Point(x:x, y:y)
				let value = valueAtPosition(position)!
				closure(position: position, value: value)
			}
		}
	}
	func enumerateNeighborsOfPosition(position0: Point, closure: (position: Point, value: T) -> Void) {
		func offset(xOffset: Int, yOffset: Int) {
			let offsetPoint = Point(x: position0.x + xOffset, y: position0.y + yOffset)
			if let value = valueAtPosition(offsetPoint) {
				closure(position: offsetPoint, value: value)
			}
		}
		offset(-1, -1)
		offset(-1, +0)
		offset(-1, +1)
		offset(+0, -1)
		offset(+0, +1)
		offset(+1, -1)
		offset(+1, +0)
		offset(+1, +1)
	}
	
	func numberOfNeighborsOfPosition(position: Point, equalToValue: T) -> Int {
		var neighbors = 0
		enumerateNeighborsOfPosition(position) {
			position, value in
			if value == equalToValue {
				neighbors++
			}
		}
		return neighbors
	}
}

