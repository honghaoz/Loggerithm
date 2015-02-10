# ZHSwiftLogger

A simple logging utility for Swift project. Just one file, you are good to go!

![](https://raw.githubusercontent.com/honghaoz/ZHSwiftLogger/master/Preview/Pre.png)

# Purpose

There's a lot of great libraries for logging, like [CocoaLumberjack](https://github.com/CocoaLumberjack/CocoaLumberjack)
[XCGLogger](https://github.com/DaveWoodCom/XCGLogger)
[Swell](https://github.com/hubertr/Swell)

However, the problem is for Swift project:

CocoaLumberjack hasn't supported Swift yet (under testing)

XCGLogger and Swell are only using `println()`, which is efficient for debugging but not actually logging (In production, we still need `NSLog` to log out info)

And this logging utility is simple and very handy to use.

# Setup

- Add `ZHLogger.swift` into your project

- Add `DEBUG` flag for Swift Compiler
  - Open project setting
  - Select your target
  - Go to `Build Settings`
  - Search `Swift`
  - In "Swift Compiler - Custom Flags" section, "Other Swift Flags" line, add `-D DEBUG`
![](https://raw.githubusercontent.com/honghaoz/ZHSwiftLogger/master/Preview/debugSetting.png)

# Usage

### Basic 
```
logVerbose()
logVerbose("This is verbose message")
logDebug("I can use format: %d + %d = %d", args: 1, 1, 2)
logInfo("This is info message")
logWarning("This is a warning")
logError("Cratical error")
```

### Advanced

There are some flags you can switch on or off
```
var logLevel = defaultDebugLevel
var ZHLogShowDateTime: Bool = true
var ZHLogShowLogLevel: Bool = true
var ZHLogShowFileName: Bool = true
var ZHLogShowLineNumber: Bool = true
var ZHLogShowFunctionName: Bool = true
```
By default, `logLevel` is `.Verbose` for development and `.Warning` for Production

All fileds are turned `on`

# Format

By default, format is 

`y-MM-dd HH:mm:ss.SSS [LogLevel] [FileName:LineNumber] functionName: message`

example:

`2014-12-18 17:58:41.381 [Verbose] [ViewController.swift:17] viewDidLoad(): This is verbose message`

# Advantages

ZHSwiftLogger will use `println()` for development and use `NSLog()` for production.

This will be faster when debugging and still have log information for production

# The MIT License (MIT)
The MIT License (MIT)
Copyright (c) 2014 Honghao Zhang

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
