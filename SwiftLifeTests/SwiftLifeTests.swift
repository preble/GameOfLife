//
//  SwiftLifeTests.swift
//  SwiftLifeTests
//
//  Created by Adam Preble on 6/25/14.
//  Copyright (c) 2014 Adam Preble. All rights reserved.
//

import XCTest
import SwiftLife

class SwiftLifeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLiveNeighbors() {
        // This is an example of a functional test case.
		let game = GameOfLife(size: CGSize(width: 3, height: 3))
		game.board.setValue(true, position: Point(x: 0, y: 1))
		game.board.setValue(true, position: Point(x: 1, y: 1))
		game.board.setValue(true, position: Point(x: 2, y: 1))
		XCTAssertEqual(game.numberOfLiveNeihgborsToPosition(Point(x: 1, y: 1)), 2, "")
		XCTAssertEqual(game.numberOfLiveNeihgborsToPosition(Point(x: 1, y: 0)), 3, "")
		XCTAssertEqual(game.numberOfLiveNeihgborsToPosition(Point(x: 0, y: 1)), 1, "")
    }
	
	func testCountNeighbors() {
		let board = GameBoard<Int>(size: Size(width: 2, height: 2), initialValue: 0)
		XCTAssertEqual(board.numberOfNeighborsOfPosition(Point(x: 0, y: 0), equalToValue: 0), 3, "")
		XCTAssertEqual(board.numberOfNeighborsOfPosition(Point(x: 0, y: 0), equalToValue: 1), 0, "")
	}
	
	func testBasicPerformance() {
		let game = GameOfLife(size: CGSize(width: 100, height: 100))
		measureBlock() {
			game.tick()
		}
	}
	
}
