//
//  Color.swift
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

#if os(iOS)
    import UIKit
    public typealias Color = UIColor
#elseif os(OSX)
    import Cocoa
    public typealias Color = NSColor
#endif

/**
*  Color logging support for Loggerithm logger.
*/
struct LoggerColor {
    static private let ESCAPE = "\u{001b}["
    
    static private let RESET_FG = ESCAPE + "fg;" // Clear any foreground color
    static private let RESET_BG = ESCAPE + "bg;" // Clear any background color
    static private let RESET = ESCAPE + ";"   // Clear any foreground or background color
    
    /// RGB Color components.
    typealias ColorTuple = (r: Int, g: Int, b: Int)
    
    /// Color for verbose log strings.
    static var verboseColor: Color? {
        didSet {
            if let verboseColor = verboseColor {
                verboseColorTuple = colorTupleForColor(verboseColor)
            } else {
                verboseColorTuple = defaultVerboseColorTuple
            }
        }
    }
    
    /// Color for debug log strings.
    static var debugColor: Color? {
        didSet {
            if let debugColor = debugColor {
                debugColorTuple = colorTupleForColor(debugColor)
            } else {
                debugColorTuple = defaultDebugColorTuple
            }
        }
    }
    
    /// Color for info log strings.
    static var infoColor: Color? {
        didSet {
            if let infoColor = infoColor {
                infoColorTuple = colorTupleForColor(infoColor)
            } else {
                infoColorTuple = defaultInfoColorTuple
            }
        }
    }
    
    /// Color for warning log strings.
    static var warningColor: Color? {
        didSet {
            if let warningColor = warningColor {
                warningColorTuple = colorTupleForColor(warningColor)
            } else {
                warningColorTuple = defaultWarningColorTuple
            }
        }
    }
    
    /// Color for error log strings.
    static var errorColor: Color? {
        didSet {
            if let errorColor = errorColor {
                errorColorTuple = colorTupleForColor(errorColor)
            } else {
                errorColorTuple = defaultErrorColorTuple
            }
        }
    }
    
    /// Default color rgb components for verbose string.
    static private var defaultVerboseColorTuple = ColorTuple(r: 190, g: 190, b: 190)
    /// Default color rgb components for debug string.
    static private var defaultDebugColorTuple = ColorTuple(r: 60, g: 161, b: 202)
    /// Default color rgb components for info string.
    static private var defaultInfoColorTuple = ColorTuple(r: 253, g: 190, b: 10)
    /// Default color rgb components for warning string.
    static private var defaultWarningColorTuple = ColorTuple(r: 251, g: 127, b: 8)
    /// Default color rgb components for error string.
    static private var defaultErrorColorTuple = ColorTuple(r: 247, g: 13, b: 23)
    
    /// Color rgb components for verbose string.
    static private var verboseColorTuple = defaultVerboseColorTuple
    /// Color rgb components for debug string.
    static private var debugColorTuple = defaultDebugColorTuple
    /// Color rgb components for info string.
    static private var infoColorTuple = defaultInfoColorTuple
    /// Color rgb components for warning string.
    static private var warningColorTuple = defaultWarningColorTuple
    /// Color rgb components for error string.
    static private var errorColorTuple = defaultErrorColorTuple
    
    /**
    Add color setting code for a string.
    
    - parameter logString: A string
    - parameter level:     A log level
    
    - returns: A string with color setting code inserted.
    */
    static func applyColorForLogString(logString: String, withLevel level: LogLevel) -> String {
        let (red, green, blue) = rgbForLogLevel(level)
        return "\(ESCAPE)fg\(red),\(green),\(blue);\(logString)\(RESET)"
    }
    
    /**
    Get corresponding color tuple for log level.
    
    - parameter level: A log level
    
    - returns: ColorTuple instance.
    */
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
    
    /**
    Get corresponding color tuple for an UIColor/NSColor.
    
    - parameter color: UIColor for iOS, NSColor for OSX
    
    - returns: ColorTuple instance.
    */
    static private func colorTupleForColor(color: Color) -> ColorTuple {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        return ColorTuple(r: Int(red * 255), g: Int(green * 255), b: Int(blue * 255))
    }
}
