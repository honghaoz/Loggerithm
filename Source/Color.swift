//
//  Color.swift
//  Demo
//
//  Created by Honghao Zhang on 2015-08-13.
//  Copyright (c) 2015 HonghaoZ. All rights reserved.
//

#if os(iOS)
    import UIKit
    public typealias Color = UIColor
#elseif os(OSX)
    import Cocoa
    public typealias Color = NSColor
#endif

struct LoggerColor {
    static private let ESCAPE = "\u{001b}["
    
    static private let RESET_FG = ESCAPE + "fg;" // Clear any foreground color
    static private let RESET_BG = ESCAPE + "bg;" // Clear any background color
    static private let RESET = ESCAPE + ";"   // Clear any foreground or background color
    
    typealias ColorTuple = (r: Int, g: Int, b: Int)
    
    static var verboseColor: Color? {
        didSet {
            if let verboseColor = verboseColor {
                verboseColorTuple = colorTupleForColor(verboseColor)
            } else {
                verboseColorTuple = defaultVerboseColorTuple
            }
        }
    }
    
    static var debugColor: Color? {
        didSet {
            if let debugColor = debugColor {
                debugColorTuple = colorTupleForColor(debugColor)
            } else {
                debugColorTuple = defaultDebugColorTuple
            }
        }
    }
    
    static var infoColor: Color? {
        didSet {
            if let infoColor = infoColor {
                infoColorTuple = colorTupleForColor(infoColor)
            } else {
                infoColorTuple = defaultInfoColorTuple
            }
        }
    }
    
    static var warningColor: Color? {
        didSet {
            if let warningColor = warningColor {
                warningColorTuple = colorTupleForColor(warningColor)
            } else {
                warningColorTuple = defaultWarningColorTuple
            }
        }
    }
    
    static var errorColor: Color? {
        didSet {
            if let errorColor = errorColor {
                errorColorTuple = colorTupleForColor(errorColor)
            } else {
                errorColorTuple = defaultErrorColorTuple
            }
        }
    }
    
    static private var defaultVerboseColorTuple = ColorTuple(r: 190, g: 190, b: 190)
    static private var defaultDebugColorTuple = ColorTuple(r: 60, g: 161, b: 202)
    static private var defaultInfoColorTuple = ColorTuple(r: 253, g: 190, b: 10)
    static private var defaultWarningColorTuple = ColorTuple(r: 251, g: 127, b: 8)
    static private var defaultErrorColorTuple = ColorTuple(r: 247, g: 13, b: 23)
    
    static private var verboseColorTuple = defaultVerboseColorTuple
    static private var debugColorTuple = defaultDebugColorTuple
    static private var infoColorTuple = defaultInfoColorTuple
    static private var warningColorTuple = defaultWarningColorTuple
    static private var errorColorTuple = defaultErrorColorTuple
    
    static func applyColorForLogString(logString: String, withLevel level: LogLevel) -> String {
        let (red, green, blue) = rgbForLogLevel(level)
        return "\(ESCAPE)fg\(red),\(green),\(blue);\(logString)\(RESET)"
    }
    
    static private func rgbForLogLevel(level: LogLevel) -> ColorTuple {
        switch level {
        case .Verbose: return verboseColorTuple
        case .Debug: return debugColorTuple
        case .Info: return infoColorTuple
        case .Warning: return warningColorTuple
        case .Error: return errorColorTuple
        default: return verboseColorTuple
        }
    }
    
    static private func colorTupleForColor(color: Color) -> ColorTuple {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        return ColorTuple(r: Int(red * 255), g: Int(green * 255), b: Int(blue * 255))
    }
}
