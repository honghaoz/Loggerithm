//
//  Type.swift
//
//  Created by Honghao Zhang on 2015-08-13.
//  Copyright (c) 2015 HonghaoZ. All rights reserved.
//

import Foundation

public enum LogLevel: Int {
	case All        = 0
	case Verbose    = 1
	case Debug      = 2
	case Info       = 3
	case Warning    = 4
	case Error      = 5
	case Off        = 6
	
	static public func descritionForLogLevel(logLevel: LogLevel) -> String {
		switch logLevel {
		case .Verbose: return "Verbose"
		case .Info:	   return "Info"
		case .Debug:   return "Debug"
		case .Warning: return "Warning"
		case .Error:   return "Error"
		default: assertionFailure("Invalid level")
		return "Null"
		}
	}
	
	// Be sure to set the "DEBUG" symbol.
	// Set it in the "Swift Compiler - Custom Flags" section, "Other Swift Flags" line. You add the DEBUG symbol with the -D DEBUG entry.
	#if DEBUG
	static public let defaultLevel = LogLevel.All
	#else
	static public let defaultLevel = LogLevel.Warning
	#endif
}

extension LogLevel: Comparable {}

public func <(lhs: LogLevel, rhs: LogLevel) -> Bool {
	return lhs.rawValue < rhs.rawValue
}

public func <=(lhs: LogLevel, rhs: LogLevel) -> Bool {
	return lhs.rawValue <= rhs.rawValue
}

public func >=(lhs: LogLevel, rhs: LogLevel) -> Bool {
	return lhs.rawValue >= rhs.rawValue
}
