//
//  DemoTests.swift
//  DemoTests
//
//  Created by Honghao Zhang on 2014-12-10.
//  Copyright (c) 2014 HonghaoZ. All rights reserved.
//

import UIKit
import XCTest
import Demo

class DemoTests: XCTestCase {
	var log = Loggerithm()
	let dateFormatter = NSDateFormatter()
	
    override func setUp() {
        super.setUp()
		dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") //24H
		dateFormatter.dateFormat = "y-MM-dd HH:mm:--.---"
		
		log.logLevel = .All
		log.showDateTime = true
		log.showLogLevel = true
		log.showFileName = true
		log.showLineNumber = true
		log.showFunctionName = true
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func testDefaultLogLevel() {
		// -D DEBUG is setup, expect .All
		XCTAssertEqual(LogLevel.defaultLevel, LogLevel.All)
	}
	
	func testLogIsOff() {
		log.logLevel = .Off
		let logString: String? = log.verbose("Hello")
		XCTAssertNil(logString)
	}
	
    func testFullFormatVerbose() {
		// Original String:  2015-08-13 16:14:30.996 [Verbose] [DemoTests.swift:26] testFullFormat(): Hello
		// Processed String: 2015-08-13 16:14:--.--- [Verbose] [DemoTests.swift:26] testFullFormat(): Hello
		// Expected String:  2015-08-13 16:14:--.--- [Verbose] [DemoTests.swift:26] testFullFormat(): Hello
		
		var logString = log.verbose("Hello"), lineNumber = __LINE__
		logString = replaceSecondsAndMilliSeconds(logString!)
		
		let expectedString = "\(dateFormatter.stringFromDate(NSDate())) [Verbose] [DemoTests.swift:\(lineNumber)] testFullFormatVerbose(): Hello"
        XCTAssertEqual(logString!, expectedString)
    }
	
	func testFullFormatDebug() {
		var logString = log.debug("Test test 123"), lineNumber = __LINE__
		logString = replaceSecondsAndMilliSeconds(logString!)
		
		let expectedString = "\(dateFormatter.stringFromDate(NSDate())) [Debug] [DemoTests.swift:\(lineNumber)] testFullFormatDebug(): Test test 123"
		XCTAssertEqual(logString!, expectedString)
	}
	
	func testFullFormatInfo() {
		var logString = log.info("Test test 123"), lineNumber = __LINE__
		logString = replaceSecondsAndMilliSeconds(logString!)
		
		let expectedString = "\(dateFormatter.stringFromDate(NSDate())) [Info] [DemoTests.swift:\(lineNumber)] testFullFormatInfo(): Test test 123"
		XCTAssertEqual(logString!, expectedString)
	}
	
	func testFullFormatWarning() {
		var logString = log.warning("Test test 123"), lineNumber = __LINE__
		logString = replaceSecondsAndMilliSeconds(logString!)
		
		let expectedString = "\(dateFormatter.stringFromDate(NSDate())) [Warning] [DemoTests.swift:\(lineNumber)] testFullFormatWarning(): Test test 123"
		XCTAssertEqual(logString!, expectedString)
	}
	
	func testFullFormatErrorFormated() {
		var logString = log.error("Error String, errorCode: %d", args: -100), lineNumber = __LINE__
		logString = replaceSecondsAndMilliSeconds(logString!)
		
		let expectedString = "\(dateFormatter.stringFromDate(NSDate())) [Error] [DemoTests.swift:\(lineNumber)] testFullFormatErrorFormated(): Error String, errorCode: -100"
		XCTAssertEqual(logString!, expectedString)
	}
	
	func testDateTimeTurnedOff() {
		log.showDateTime = false
	}
	
	// MARK: - Helper
	func replaceSecondsAndMilliSeconds(string: String) -> String {
		let pattern = "(\\d{2}).\\d{3}"
		let regex = NSRegularExpression(pattern: pattern, options: nil, error: nil)!
		return regex.stringByReplacingMatchesInString(string, options: nil, range: NSMakeRange(0, count(string)), withTemplate: "--.---")
	}
}
