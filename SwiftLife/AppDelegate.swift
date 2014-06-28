//
//  AppDelegate.swift
//  SwiftLife
//
//  Created by Adam Preble on 6/25/14.
//  Copyright (c) 2014 Adam Preble. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
	
	var mainWindowController: MainWindowController?
                            
	func applicationDidFinishLaunching(aNotification: NSNotification?) {
		// Insert code here to initialize your application
		mainWindowController = MainWindowController()
		mainWindowController!.showWindow(nil)
	}

	func applicationWillTerminate(aNotification: NSNotification?) {
		// Insert code here to tear down your application
	}

}

