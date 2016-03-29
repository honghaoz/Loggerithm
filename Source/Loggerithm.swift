//
//  Loggerithm.swift
//  Loggerithm
//
//  Created by Honghao Zhang on 2014-12-10.
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

public struct Loggerithm {
    /// A default logger instance.
    public static let defaultLogger = Loggerithm()
    
    /// Log level current used.
    public var logLevel = LogLevel.defaultLevel
    
    /// Whether should show date & time field, ture for showing, false for hidding.
    public var showDateTime = true
    /// Whether should show log level field, ture for showing, false for hidding.
    public var showLogLevel = true
    /// Whether should show file name field, ture for showing, false for hidding.
    public var showFileName = true
    /// Whether should show line number field, ture for showing, false for hidding.
    public var showLineNumber = true
    /// Whether should show function name field, ture for showing, false for hidding.
    public var showFunctionName = true
    
    /// Whether should output color log.
    public var useColorfulLog = false
    
    /// Color used for verbose log string.
    public var verboseColor: Color? {
        set {
            LoggerColor.verboseColor = newValue
        }
        
        get {
            return LoggerColor.verboseColor
        }
    }
    
    /// Color used for debug log string.
    public var debugColor: Color? {
        set {
            LoggerColor.debugColor = newValue
        }
        
        get {
            return LoggerColor.debugColor
        }
    }
    
    /// Color used for info log string.
    public var infoColor: Color? {
        set {
            LoggerColor.infoColor = newValue
        }
        
        get {
            return LoggerColor.infoColor
        }
    }
    
    /// Color used for warning log string.
    public var warningColor: Color? {
        set {
            LoggerColor.warningColor = newValue
        }
        
        get {
            return LoggerColor.warningColor
        }
    }
    
    /// Color used for error log string.
    public var errorColor: Color? {
        set {
            LoggerColor.errorColor = newValue
        }
        
        get {
            return LoggerColor.errorColor
        }
    }
    
    /// NSDateFromatter used internally.
    private let dateFormatter = NSDateFormatter()
    
    /// LogFunction used, print for DEBUG, NSLog for Production.
    #if DEBUG
    private let LogFunction: (format: String) -> Void = {format in print(format)}
    private let UsingNSLog = false
    #else
    private let LogFunction: (format: String, args: CVarArgType...) -> Void = NSLog
    private let UsingNSLog = true
    #endif
    
    public init() {
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") //24H
        dateFormatter.dateFormat = "y-MM-dd HH:mm:ss.SSS"
        
        // Check to see whether XcodeColors is installed and enabled
        // useColorfulLog will be turned on when environment variable "XcodeColors" == "YES"
        if let xcodeColorsEnabled = NSProcessInfo().environment["XcodeColors"] as String? where xcodeColorsEnabled == "YES" {
            useColorfulLog = true
        }
    }
    
    /**
    Prinln an new line, without any fileds. This will ignore any filed settings.
    */
    public func emptyLine() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.LogFunction(format: "")
        })
    }
    
    /**
    Logs textual representation of `value` with .Verbose level.
    
    - parameter value:    A value conforms `Streamable`, `Printable`, `DebugPrintable`.
    - parameter function: Function name
    - parameter file:     File name
    - parameter line:     Line number
    
    - returns: The string logged out.
    */
    public func verbose<T>(value: T, function: String = #function, file: String = #file, line: Int = #line) -> String? {
        return verbose("\(value)", function: function, file: file,  line: line)
    }
    
    /**
    Logs an message with formatted string and arguments list with .Verbose level.
    
    - parameter format:   Formatted string
    - parameter function: Function name
    - parameter file:     File name
    - parameter line:     Line number
    - parameter args:     Arguments list
    
    - returns: The string logged out.
    */
    public func verbose(format: String = "", function: String = #function, file: String = #file, line: Int = #line, args: CVarArgType...) -> String? {
        if .Verbose >= logLevel {
            return log(.Verbose, function: function, file: file,  line: line, format: format, args: args)
        }
        return nil
    }
    
    /**
    Logs textual representation of `value` with .Debug level.
    
    - parameter value:    A value conforms `Streamable`, `Printable`, `DebugPrintable`.
    - parameter function: Function name
    - parameter file:     File name
    - parameter line:     Line number
    
    - returns: The string logged out.
    */
    public func debug<T>(value: T, function: String = #function, file: String = #file, line: Int = #line) -> String? {
        return debug("\(value)", function: function, file: file,  line: line)
    }
    
    /**
    Logs an message with formatted string and arguments list with .Debug level.
    
    - parameter format:   Formatted string
    - parameter function: Function name
    - parameter file:     File name
    - parameter line:     Line number
    - parameter args:     Arguments list
    
    - returns: The string logged out.
    */
    public func debug(format: String = "", function: String = #function, file: String = #file, line: Int = #line, args: CVarArgType...) -> String?
    {
        if .Debug >= logLevel {
            return log(.Debug, function: function, file: file, line: line, format: format, args: args)
        }
        return nil
    }
    
    /**
    Logs textual representation of `value` with .Info level.
    
    - parameter value:    A value conforms `Streamable`, `Printable`, `DebugPrintable`.
    - parameter function: Function name
    - parameter file:     File name
    - parameter line:     Line number
    
    - returns: The string logged out.
    */
    public func info<T>(value: T, function: String = #function, file: String = #file, line: Int = #line) -> String? {
        return info("\(value)", function: function, file: file,  line: line)
    }
    
    /**
    Logs an message with formatted string and arguments list with .Info level.
    
    - parameter format:   Formatted string
    - parameter function: Function name
    - parameter file:     File name
    - parameter line:     Line number
    - parameter args:     Arguments list
    
    - returns: The string logged out.
    */
    public func info(format: String = "", function: String = #function, file: String = #file, line: Int = #line, args: CVarArgType...) -> String?
    {
        if .Info >= logLevel {
            return log(.Info, function: function, file: file, line: line, format: format, args: args)
        }
        return nil
    }
    
    /**
    Logs textual representation of `value` with .Warning level.
    
    - parameter value:    A value conforms `Streamable`, `Printable`, `DebugPrintable`.
    - parameter function: Function name
    - parameter file:     File name
    - parameter line:     Line number
    
    - returns: The string logged out.
    */
    public func warning<T>(value: T, function: String = #function, file: String = #file, line: Int = #line) -> String? {
        return warning("\(value)", function: function, file: file,  line: line)
    }
    
    /**
    Logs an message with formatted string and arguments list with .Warning level.
    
    - parameter format:   Formatted string
    - parameter function: Function name
    - parameter file:     File name
    - parameter line:     Line number
    - parameter args:     Arguments list
    
    - returns: The string logged out.
    */
    public func warning(format: String = "", function: String = #function, file: String = #file, line: Int = #line, args: CVarArgType...) -> String?
    {
        if .Warning >= logLevel {
            return log(.Warning, function: function, file: file, line: line, format: format, args: args)
        }
        return nil
    }
    
    /**
    Logs textual representation of `value` with .Error level.
    
    - parameter value:    A value conforms `Streamable`, `Printable`, `DebugPrintable`.
    - parameter function: Function name
    - parameter file:     File name
    - parameter line:     Line number
    
    - returns: The string logged out.
    */
    public func error<T>(value: T, function: String = #function, file: String = #file, line: Int = #line) -> String? {
        return error("\(value)", function: function, file: file,  line: line)
    }
    
    /**
    Logs an message with formatted string and arguments list with .Error level.
    
    - parameter format:   Formatted string
    - parameter function: Function name
    - parameter file:     File name
    - parameter line:     Line number
    - parameter args:     Arguments list
    
    - returns: The string logged out.
    */
    public func error(format: String = "", function: String = #function, file: String = #file, line: Int = #line, args: CVarArgType...) -> String?
    {
        if .Error >= logLevel {
            return log(.Error, function: function, file: file, line: line, format: format, args: args)
        }
        return nil
    }
    
    /**
    Logs an message with formatted string and arguments list.
    
    - parameter level:    Log level
    - parameter format:   Formatted string
    - parameter function: Function name
    - parameter file:     File name
    - parameter line:     Line number
    - parameter args:     Arguments list
    
    - returns: The string logged out.
    */
    public func logWithLevel(level: LogLevel, _ format: String = "", function: String = #function, file: String = #file, line: Int = #line, args: CVarArgType...) -> String?
    {
        if level >= logLevel {
            return log(level, file: file, function: function, line: line, format: format, args: args)
        }
        return nil
    }
    
    /**
    Construct a log message, log it out and return it.
    
    - parameter level:    Log level
    - parameter function: Function name
    - parameter file:     File name
    - parameter line:     Line number
    - parameter format:   Formatted string
    - parameter args:     Arguments list
    
    - returns: The string logged out.
    */
    private func log(level: LogLevel, function: String = #function, file: String = #file, line: Int = #line, format: String, args: [CVarArgType]) -> String
    {
        let dateTime = showDateTime ? (UsingNSLog ? "" : "\(dateFormatter.stringFromDate(NSDate())) ") : ""
        let levelString = showLogLevel ? "[\(LogLevel.descritionForLogLevel(level))] " : ""
        
        var fileLine = ""
        if showFileName {
            fileLine += "[" + (file as NSString).lastPathComponent
            if showLineNumber {
                fileLine += ":\(line)"
            }
            fileLine += "] "
        }
        
        let functionString = showFunctionName ? function : ""
        
        let message: String
        if args.count == 0 {
            message = format
        } else {
            message = String(format: format, arguments: args)
        }
        
        let infoString = "\(dateTime)\(levelString)\(fileLine)\(functionString)".stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: " "))
        
        let logString = infoString + (infoString.isEmpty ? "" : ": ") + "\(message)"
        let outputString = useColorfulLog ? LoggerColor.applyColorForLogString(logString, withLevel: level) : logString
        
//        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.LogFunction(format: outputString)
//        })
        
        return logString
    }
}
