//
//  DemoTests.swift
//  DemoTests
//
//  Created by Honghao Zhang on 2014-12-10.
//  Copyright (c) 2014 HonghaoZ. All rights reserved.
//

import Foundation
import XCTest

class DemoTests: XCTestCase {
	var log = Loggerithm()
	let dateFormatter = DateFormatter()
	
    override func setUp() {
        super.setUp()
		dateFormatter.locale = Locale(identifier: "en_US_POSIX") //24H
		dateFormatter.dateFormat = "y-MM-dd HH:mm:--.---"
		
		log.logLevel = .all
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
		XCTAssertEqual(LogLevel.defaultLevel, LogLevel.all)
	}
	
	func testLogIsOff() {
		log.logLevel = .off
		let logString: String? = log.verbose("Hello")
		XCTAssertNil(logString)
	}
	
    func testFullFormatVerbose() {
		// Original String:  2015-08-13 16:14:30.996 [Verbose] [DemoTests.swift:26] testFullFormat(): Hello
		// Processed String: 2015-08-13 16:14:--.--- [Verbose] [DemoTests.swift:26] testFullFormat(): Hello
		// Expected String:  2015-08-13 16:14:--.--- [Verbose] [DemoTests.swift:26] testFullFormat(): Hello
		
		var logString = log.verbose("Hello"), lineNumber = #line
		logString = replaceSecondsAndMilliSeconds(logString!)
		
		let expectedString = "\(dateFormatter.string(from: Date())) [Verbose] [DemoTests.swift:\(lineNumber)] testFullFormatVerbose(): Hello"
        XCTAssertEqual(logString!, expectedString)
    }
	
	func testFullFormatDebug() {
		var logString = log.debug("Test test 123"), lineNumber = #line
		logString = replaceSecondsAndMilliSeconds(logString!)
		
		let expectedString = "\(dateFormatter.string(from: Date())) [Debug] [DemoTests.swift:\(lineNumber)] testFullFormatDebug(): Test test 123"
		XCTAssertEqual(logString!, expectedString)
	}
	
	func testFullFormatInfo() {
		var logString = log.info("Test test 123"), lineNumber = #line
		logString = replaceSecondsAndMilliSeconds(logString!)
		
		let expectedString = "\(dateFormatter.string(from: Date())) [Info] [DemoTests.swift:\(lineNumber)] testFullFormatInfo(): Test test 123"
		XCTAssertEqual(logString!, expectedString)
	}
	
	func testFullFormatWarning() {
		var logString = log.warning("Test test 123"), lineNumber = #line
		logString = replaceSecondsAndMilliSeconds(logString!)
		
		let expectedString = "\(dateFormatter.string(from: Date())) [Warning] [DemoTests.swift:\(lineNumber)] testFullFormatWarning(): Test test 123"
		XCTAssertEqual(logString!, expectedString)
	}
	
	func testFullFormatErrorFormated() {
		var logString = log.error("Error String, errorCode: %d", args: -100), lineNumber = #line
		logString = replaceSecondsAndMilliSeconds(logString!)
		
		let expectedString = "\(dateFormatter.string(from: Date())) [Error] [DemoTests.swift:\(lineNumber)] testFullFormatErrorFormated(): Error String, errorCode: -100"
		XCTAssertEqual(logString!, expectedString)
	}
	
	func testDateTimeTurnedOff() {
		log.showDateTime = false
	}
	
	// MARK: - Helper
	func replaceSecondsAndMilliSeconds(_ string: String) -> String {
		let pattern = "(\\d{2}).\\d{3}"
		let regex = try! NSRegularExpression(pattern: pattern, options: [])
		return regex.stringByReplacingMatches(in: string, options: [], range: NSMakeRange(0, string.characters.count), withTemplate: "--.---")
	}
}
