# Loggerithm
[![CI Status](http://img.shields.io/travis/honghaoz/Loggerithm.svg?style=flat)](https://travis-ci.org/honghaoz/Loggerithm)
[![Cocoapods Version](https://img.shields.io/cocoapods/v/Loggerithm.svg?style=flat)](http://cocoapods.org/pods/Loggerithm)
[![License](https://img.shields.io/cocoapods/l/Loggerithm.svg?style=flat)](http://cocoapods.org/pods/Loggerithm)
[![Platform](https://img.shields.io/cocoapods/p/Loggerithm.svg?style=flat)](http://cocoapods.org/pods/Loggerithm)

A lightweight Swift logger, uses `println` in Debug and `NSLog` in Production with colourful output.

![](https://raw.githubusercontent.com/honghaoz/Loggerithm/master/Assets/demo.png)

## Why

There's a lot of great libraries for logging, like [CocoaLumberjack](https://github.com/CocoaLumberjack/CocoaLumberjack),
[XCGLogger](https://github.com/DaveWoodCom/XCGLogger),
[Swell](https://github.com/hubertr/Swell)

However, the problems are:

- CocoaLumberjack is not for Swift and it's not lightweight

- XCGLogger and Swell are only using `println()`, which is efficient for debugging but not actually logging anything (In production, we still need `NSLog` to log out informations)

And **Loggerithm** is clear and very handy to use.

## Features
- [x] Use `println` in Debug and `NSLog` in Production.
- [x] Formatted output, just like `NSLog`.
- [x] Log level Support.
- [x] Colorful output and color customization.
- [x] Comprehensive Unit Test Coverage.

## Installation

### Cocoapods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

To integrate **Loggerithm** into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

pod 'Loggerithm', '~> 1.1'
```

Then, run the following command:

```bash
$ pod install
```

### Manually
- Add Swift files in **Source** folder into your project

- Add `DEBUG` flag to Swift Compiler:
  - Open project setting
  - Select your target
  - Go to `Build Settings`
  - Search `Swift`
  - Under **Swift Compiler - Custom Flags** section, in **Other Swift Flags** line, add `-D DEBUG`
![](https://raw.githubusercontent.com/honghaoz/Loggerithm/master/Assets/settings.png)

### Colorful Output Support
Need [XcodeColors](https://github.com/robbiehanson/XcodeColors) plugin installed.

#### XcodeColors Installation
- You can fork [XcodeColors](https://github.com/robbiehanson/XcodeColors) repo and build to install it.
- Or use [Alcatraz](http://alcatraz.io) to install it

#### Setup Environment Variable
To let logger automatically turn on, you need to add `"XcodeColors" = "YES"` environment variable to your build scheme.

This can be done in following way:
![](https://raw.githubusercontent.com/honghaoz/Loggerithm/master/Assets/schele-select.png)
![](https://raw.githubusercontent.com/honghaoz/Loggerithm/master/Assets/environment.png)

You can also manually force to turn on/off colorful output by modifying `useColorfulLog` property

## Usage

### Basic 
> If you are using Cocoapods to integrate Loggerithm. Import Loggerithm first:
> ```swift
> import Loggerithm
> ```

```swift
var log = Loggerithm()

// Usage example
log.verbose("Verbose message...")
log.debug("Debug message...")
log.info("Info message...")
log.warning("Warning message...")
log.error("Error message...")
```

Results:
![](https://raw.githubusercontent.com/honghaoz/Loggerithm/master/Assets/basic.png)

### Log Levels

By default, `logLevel` is `.Verbose` for development and `.Warning` for Production.

`LogLevel` from low to high is 
> `.All`
>
> `.Verbose` 
>
> `.Debug` 
>
> `.Info` 
>
> `.Warning` 
>
> `.Error` 
>
> `.Off`

Logging with level lower than `logLevel` will be ignored.

### Advanced

#### Format

Log string containts 5 fields, format is:

> `y-MM-dd HH:mm:ss.SSS [LogLevel] [FileName:LineNumber] functionName: message`

All logging fields can be turned on/off:
```swift
var log = Loggerithm()

log.showDateTime = false
log.info("date time is turned off.")

log.showLineNumber = false
log.info("Line number is turned off.")

log.showFileName = false
log.info("File name is turned off.")

log.showFunctionName = false
log.info("Function name is turned off.")

log.showLogLevel = false
log.info("Log level is turned off.")

log.emptyLine()
log.info("Restoring to full format...")
```

Results:
![](https://raw.githubusercontent.com/honghaoz/Loggerithm/master/Assets/fields.png)

#### Formatted Output

```swift
var log = Loggerithm()
log.verboseWithFormat("I can use format: %d + %d = %d", args: 1, 1, 2)
```

Results:
![](https://raw.githubusercontent.com/honghaoz/Loggerithm/master/Assets/formatted.png)

### Color Customization


```swift
var log = Loggerithm()

log.verboseColor = UIColor.grayColor()
log.debugColor = UIColor.greenColor()
log.infoColor = UIColor.yellowColor()
log.warningColor = UIColor.orangeColor()
log.errorColor = UIColor.redColor()

log.verbose("Verbose message...")
log.debug("Debug message...")
log.info("Info message...")
log.warning("Warning message...")
log.error("Error message...")
```

Results:
![](https://raw.githubusercontent.com/honghaoz/Loggerithm/master/Assets/color.png)

## TODO

- [ ] Log into file

## The MIT License (MIT)
The MIT License (MIT)
Copyright (c) 2014 Honghao Zhang (张宏昊)

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
