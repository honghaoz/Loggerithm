//
//  ViewController.swift
//  Demo
//
//  Created by Honghao Zhang on 2014-12-10.
//  Copyright (c) 2014 HonghaoZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	var cleanLogger = Loggerithm()
	
	func setupLocalLogger() {
		cleanLogger.showDateTime = false
		cleanLogger.showLogLevel = false
		cleanLogger.showFileName = false
		cleanLogger.showLineNumber = false
		cleanLogger.showFunctionName = false
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		// Logger is setup in AppDelegate.swift
		setupLocalLogger()
		
		// Usage example
        log.verbose("Verbose message...")
		log.debug("Debug message...")
		log.info("Info message...")
		log.warning("Warning message...")
		log.error("Error message...")
		
		log.emptyLine()
        log.showDateTime = false
        log.info("date time is turned off.")
		
		log.showLineNumber = false
		log.info("Line number is turned off.")
		
		log.showFileName = false
		log.info("File name is turned off.")
		
		log.showFunctionName = false
		log.info("Function name is turned off.")
		
		log.showLogLevel = false
		log.info("Log level is turned off.")
		
		log.emptyLine()
		log.info("Restoring to full format...")
		
		log.showDateTime = true
		log.showLogLevel = true
		log.showFileName = true
		log.showLineNumber = true
		log.showFunctionName = true
		
		log.verboseWithFormat("I can use format: %d + %d = %d", args: 1, 1, 2)
		
		// Customize Color
		cleanLogger.emptyLine()
		cleanLogger.info("Customizing color...")
		log.verboseColor = UIColor.grayColor()
		log.debugColor = UIColor.greenColor()
		log.infoColor = UIColor.yellowColor()
		log.warningColor = UIColor.orangeColor()
		log.errorColor = UIColor.redColor()
		
		log.verbose("Verbose message...")
		log.debug("Debug message...")
		log.info("Info message...")
		log.warning("Warning message...")
		log.error("Error message...")
    }
}
