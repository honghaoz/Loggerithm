//
//  Loggerithm.swift
//
//  Created by Honghao Zhang on 2014-12-10.
//  Copyright (c) 2014 HonghaoZ. All rights reserved.
//

import UIKit

public struct Loggerithm {
    public static let defaultLogger = Loggerithm()
    
    public var logLevel = LogLevel.defaultLevel
    
    public var showDateTime = true
    public var showLogLevel = true
    public var showFileName = true
    public var showLineNumber = true
    public var showFunctionName = true
    
    public var verboseColor: UIColor? {
        set {
            LoggerColor.verboseColor = newValue
        }
        
        get {
            return LoggerColor.verboseColor
        }
    }
    
    public var debugColor: UIColor? {
        set {
            LoggerColor.debugColor = newValue
        }
        
        get {
            return LoggerColor.debugColor
        }
    }
    
    public var infoColor: UIColor? {
        set {
            LoggerColor.infoColor = newValue
        }
        
        get {
            return LoggerColor.infoColor
        }
    }
    
    public var warningColor: UIColor? {
        set {
            LoggerColor.warningColor = newValue
        }
        
        get {
            return LoggerColor.warningColor
        }
    }
    
    public var errorColor: UIColor? {
        set {
            LoggerColor.errorColor = newValue
        }
        
        get {
            return LoggerColor.errorColor
        }
    }
    
    private let dateFormatter = NSDateFormatter()
    
    #if DEBUG
    private let LogFunction: (format: String) -> Void = println
    private let UsingNSLog = false
    #else
    private let LogFunction: (format: String, args: CVarArgType...) -> Void = NSLog
    private let UsingNSLog = true
    #endif
    
    public init() {
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") //24H
        dateFormatter.dateFormat = "y-MM-dd HH:mm:ss.SSS"
    }
    
    public func emptyLine() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.LogFunction(format: "")
        })
    }
    
    public func verbose(function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__) -> String? {
        return verbose("", function: function, file: file,  line: line)
    }
    
    public func verbose<T>(value: T, function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__) -> String? {
        return verboseWithFormat("\(value)", function: function, file: file,  line: line)
    }
    
    public func verboseWithFormat(_ format: String = "", function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__, args: CVarArgType...) -> String? {
        if .Verbose >= logLevel {
            return log(.Verbose, function: function, file: file,  line: line, format: format, args: getVaList(args))
        }
        return nil
    }
    
    public func debug(function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__) -> String? {
        return debug("", function: function, file: file,  line: line)
    }
    
    public func debug<T>(value: T, function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__) -> String? {
        return debugWithFormat("\(value)", function: function, file: file,  line: line)
    }
    
    public func debugWithFormat(_ format: String = "", function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__, args: CVarArgType...) -> String?
    {
        if .Debug >= logLevel {
            return log(.Debug, function: function, file: file, line: line, format: format, args: getVaList(args))
        }
        return nil
    }
    
    public func info(function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__) -> String? {
        return info("", function: function, file: file,  line: line)
    }
    
    public func info<T>(value: T, function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__) -> String? {
        return infoWithFormat("\(value)", function: function, file: file,  line: line)
    }
    
    public func infoWithFormat(_ format: String = "", function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__, args: CVarArgType...) -> String?
    {
        if .Info >= logLevel {
            return log(.Info, function: function, file: file, line: line, format: format, args: getVaList(args))
        }
        return nil
    }
    
    public func warning(function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__) -> String? {
        return warning("", function: function, file: file,  line: line)
    }
    
    public func warning<T>(value: T, function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__) -> String? {
        return warningWithFormat("\(value)", function: function, file: file,  line: line)
    }
    
    public func warningWithFormat(_ format: String = "", function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__, args: CVarArgType...) -> String?
    {
        if .Warning >= logLevel {
            return log(.Warning, function: function, file: file, line: line, format: format, args: getVaList(args))
        }
        return nil
    }
    
    public func error(function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__) -> String? {
        return error("", function: function, file: file,  line: line)
    }
    
    public func error<T>(value: T, function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__) -> String? {
        return errorWithFormat("\(value)", function: function, file: file,  line: line)
    }
    
    public func errorWithFormat(_ format: String = "", function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__, args: CVarArgType...) -> String?
    {
        if .Error >= logLevel {
            return log(.Error, function: function, file: file, line: line, format: format, args: getVaList(args))
        }
        return nil
    }
    
    public func logWithLevel(level: LogLevel, _ format: String = "", function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__, args: CVarArgType...) -> String?
    {
        if level >= logLevel {
            return log(level, file: file, function: function, line: line, format: format, args: getVaList(args))
        }
        return nil
    }
    
    private func log(level: LogLevel, function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__, format: String, args: CVaListPointer) -> String
    {
        let dateTime = showDateTime ? (UsingNSLog ? "" : "\(dateFormatter.stringFromDate(NSDate())) ") : ""
        let levelString = showLogLevel ? "[\(LogLevel.descritionForLogLevel(level))] " : ""
        
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
        let infoString = "\(dateTime)\(levelString)\(fileLine)\(functionString)".stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: " "))
        
        let logString = infoString + (infoString.isEmpty ? "" : ": ") + "\(message)"
        let colorLogString = LoggerColor.applyColorForLogString(logString, withLevel: level)
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.LogFunction(format: colorLogString)
        })
        
        return logString
    }
}
