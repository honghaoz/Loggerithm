//
//  ZHLogger.swift
//
//  Created by Honghao Zhang on 2014-12-10.
//  Copyright (c) 2014 HonghaoZ. All rights reserved.
//

import Foundation

// Public
var logLevel = defaultDebugLevel
var ZHLogShowDateTime: Bool = true
var ZHLogShowLogLevel: Bool = true
var ZHLogShowFileName: Bool = true
var ZHLogShowLineNumber: Bool = true
var ZHLogShowFunctionName: Bool = true

enum ZHLogLevel: Int {
    case All        = 0
    case Verbose    = 10
    case Debug      = 20
    case Info       = 30
    case Warning    = 40
    case Error      = 50
    case Off        = 60
    static func logLevelString(logLevel: ZHLogLevel) -> String {
        switch logLevel {
        case .Verbose: return "Verbose"
        case .Info: return "Info"
        case .Debug: return "Debug"
        case .Warning: return "Warning"
        case .Error: return "Error"
        default: assertionFailure("Invalid level to get string")
        }
    }
}

// Be sure to set the "DEBUG" symbol.
// Set it in the "Swift Compiler - Custom Flags" section, "Other Swift Flags" line. You add the DEBUG symbol with the -D DEBUG entry.
#if DEBUG
    let defaultDebugLevel = ZHLogLevel.All
    #else
    let defaultDebugLevel = ZHLogLevel.Warning
#endif

var _ZHLogDateFormatter: NSDateFormatter?
var ZHLogDateFormatter: NSDateFormatter = {
    if _ZHLogDateFormatter == nil {
        _ZHLogDateFormatter = NSDateFormatter()
        _ZHLogDateFormatter!.locale = NSLocale(localeIdentifier: "en_US_POSIX") //24H
        _ZHLogDateFormatter!.dateFormat = "y-MM-dd HH:mm:ss.SSS"
    }
    return _ZHLogDateFormatter!
}()

// Default
#if DEBUG
    var ZHLogFunc: (format: String) -> Void = println
    var ZHLogUsingNSLog: Bool = false
    #else
    var ZHLogFunc: (format: String, args: CVarArgType...) -> Void = NSLog
    var ZHLogUsingNSLog: Bool = true
#endif

func logVerbose(_ logText: String = "",
    file: String = __FILE__,
    line: UWord = __LINE__,
    function: String = __FUNCTION__,
    #args: CVarArgType...)
{
    if ZHLogLevel.Verbose.rawValue >= logLevel.rawValue {
        log(.Verbose, file: file, function: function, line: line, logText, args: getVaList(args))
    }
}

func logInfo(_ logText: String = "",
    file: String = __FILE__,
    line: UWord = __LINE__,
    function: String = __FUNCTION__,
    #args: CVarArgType...)
{
    if ZHLogLevel.Info.rawValue >= logLevel.rawValue {
        log(.Info, file: file, function: function, line: line, logText, args: getVaList(args))
    }
}

func logDebug(_ logText: String = "",
    file: String = __FILE__,
    line: UWord = __LINE__,
    function: String = __FUNCTION__,
    #args: CVarArgType...)
{
    if ZHLogLevel.Debug.rawValue >= logLevel.rawValue {
        log(.Debug, file: file, function: function, line: line, logText, args: getVaList(args))
    }
}

func logWarning(_ logText: String = "",
    file: String = __FILE__,
    line: UWord = __LINE__,
    function: String = __FUNCTION__,
    #args: CVarArgType...)
{
    if ZHLogLevel.Warning.rawValue >= logLevel.rawValue {
        log(.Warning, file: file, function: function, line: line, logText, args: getVaList(args))
    }
}

func logError(_ logText: String = "",
    file: String = __FILE__,
    line: UWord = __LINE__,
    function: String = __FUNCTION__,
    #args: CVarArgType...)
{
    if ZHLogLevel.Error.rawValue >= logLevel.rawValue {
        log(.Error, file: file, function: function, line: line, logText, args: getVaList(args))
    }
}

private func log(level: ZHLogLevel, file: String = __FILE__, var function: String = __FUNCTION__, line: UWord = __LINE__, format: String, #args: CVaListPointer) {
    let time: String = ZHLogShowDateTime ? (ZHLogUsingNSLog ? "" : "\(ZHLogDateFormatter.stringFromDate(NSDate())) ") : ""
    let level: String = ZHLogShowLogLevel ? "[\(ZHLogLevel.logLevelString(level))] " : ""
    var fileLine: String = ""
    if ZHLogShowFileName {
        fileLine += "[" + file.lastPathComponent
        if ZHLogShowLineNumber {
            fileLine += ":\(line)"
        }
        fileLine += "] "
    }
    if !ZHLogShowFunctionName { function = "" }
    let message = NSString(format: format, arguments: args) as String
    let logText = "\(time)\(level)\(fileLine)\(function): \(message)"
    
    ZHLogFunc(format: logText)
}