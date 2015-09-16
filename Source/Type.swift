//
//  Type.swift
//  Loggerithm
//
//  Created by Honghao Zhang on 2015-08-13.
//  Copyright (c) 2015 Honghao Zhang (张宏昊)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation

/**
Log level used in Loggerithm logger.

- All:     Log with any level will be logged out
- Verbose: Log out string with level greate than or equal to .Verbose
- Debug:   Log out string with level greate than or equal to .Debug
- Info:    Log out string with level greate than or equal to .Info
- Warning: Log out string with level greate than or equal to .Warning
- Error:   Log out string with level greate than or equal to .Error
- Off:     Log is turned off
*/
public enum LogLevel: Int {
    case All        = 0
    case Verbose    = 1
    case Debug      = 2
    case Info       = 3
    case Warning    = 4
    case Error      = 5
    case Off        = 6
    
    /**
    Get string description for log level.
    
    - parameter logLevel: A LogLevel
    
    - returns: A string.
    */
    static public func descritionForLogLevel(logLevel: LogLevel) -> String {
        switch logLevel {
        case .Verbose: return "Verbose"
        case .Debug:   return "Debug"
        case .Info:    return "Info"
        case .Warning: return "Warning"
        case .Error:   return "Error"
        default: assertionFailure("Invalid level")
        return "Null"
        }
    }
    
    /// Defualt log level
    /// Be sure to set the "DEBUG" symbol.
    /// Set it in the "Swift Compiler - Custom Flags" section, "Other Swift Flags" line. Add "-D DEBUG" entry.
    #if DEBUG
    static public let defaultLevel = LogLevel.All
    #else
    static public let defaultLevel = LogLevel.Warning
    #endif
}

// MARK: - Comparable
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
