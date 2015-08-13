//
//  Logarithm.swift
//
//  Created by Honghao Zhang on 2014-12-10.
//  Copyright (c) 2014 HonghaoZ. All rights reserved.
//

import Foundation

public struct Logarithm {
	public static let defaultLogger = Logarithm()
	
	public var logLevel = LogLevel.defaultLevel
	
	public var showDateTime = true
	public var showLogLevel = true
	public var showFileName = true
	public var showLineNumber = true
	public var showFunctionName = true
	
	private var dateFormatter: NSDateFormatter = {
		let dateFormatter = NSDateFormatter()
		dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") //24H
		dateFormatter.dateFormat = "y-MM-dd HH:mm:ss.SSS"
		return dateFormatter
	}()
	
	#if DEBUG
	private let LogFunction: (format: String) -> Void = println
	private let UsingNSLog = false
	#else
	private let LogFunction: (format: String, args: CVarArgType...) -> Void = NSLog
	private let UsingNSLog = true
	#endif
	
	public init() {}
	
	public func verbose(_ logText: String = "",
		function: String = __FUNCTION__,
		file: String = __FILE__,
		line: Int = __LINE__,
		args: CVarArgType...) -> String?
	{
		if .Verbose >= logLevel {
			return log(.Verbose, function: function, file: file,  line: line, format: logText, args: getVaList(args))
		}
		return nil
	}
	
	public func info(_ logText: String = "",
		function: String = __FUNCTION__,
		file: String = __FILE__,
		line: Int = __LINE__,
		args: CVarArgType...) -> String?
	{
		if .Info >= logLevel {
			return log(.Info, function: function, file: file, line: line, format: logText, args: getVaList(args))
		}
		return nil
	}
	
	public func debug(_ logText: String = "",
		function: String = __FUNCTION__,
		file: String = __FILE__,
		line: Int = __LINE__,
		args: CVarArgType...) -> String?
	{
		if .Debug >= logLevel {
			return log(.Debug, function: function, file: file, line: line, format: logText, args: getVaList(args))
		}
		return nil
	}
	
	public func warning(_ logText: String = "",
		function: String = __FUNCTION__,
		file: String = __FILE__,
		line: Int = __LINE__,
		args: CVarArgType...) -> String?
	{
		if .Warning >= logLevel {
			return log(.Warning, function: function, file: file, line: line, format: logText, args: getVaList(args))
		}
		return nil
	}
	
	public func error(_ logText: String = "",
		function: String = __FUNCTION__,
		file: String = __FILE__,
		line: Int = __LINE__,
		args: CVarArgType...) -> String?
	{
		if .Error >= logLevel {
			return log(.Error, function: function, file: file, line: line, format: logText, args: getVaList(args))
		}
		return nil
	}
	
	public func logWithLevel(level: LogLevel,
		_ logText: String = "",
		function: String = __FUNCTION__,
		file: String = __FILE__,
		line: Int = __LINE__,
		args: CVarArgType...) -> String?
	{
		if level >= logLevel {
			return log(level, file: file, function: function, line: line, format: logText, args: getVaList(args))
		}
		return nil
	}
	
	private func log(level: LogLevel,
		function: String = __FUNCTION__,
		file: String = __FILE__,
		line: Int = __LINE__,
		format: String,
		args: CVaListPointer) -> String
	{
		let dateTime = showDateTime ? (UsingNSLog ? "" : "\(dateFormatter.stringFromDate(NSDate())) ") : ""
		let level = showLogLevel ? "[\(LogLevel.descritionForLogLevel(level))] " : ""
		
		var fileLine = ""
		if showFileName {
			fileLine += "[" + file.lastPathComponent
			if showLineNumber {
				fileLine += ":\(line)"
			}
			fileLine += "] "
		}
		
		let functionString = showFunctionName ? function : ""
		
		let message = NSString(format: format, arguments: args) as String
		let infoString = "\(dateTime)\(level)\(fileLine)\(functionString)".stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: " "))
		let logString = infoString + (infoString.isEmpty ? "" : ": ") + "\(message)"

		dispatch_async(dispatch_get_main_queue(), { () -> Void in
			self.LogFunction(format: logString)
		})
		
		return logString
	}
	
	public func emptyLine() {
		dispatch_async(dispatch_get_main_queue(), { () -> Void in
			self.LogFunction(format: "")
		})
	}
}
