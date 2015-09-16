# Loggerithm
[![CI Status](https://travis-ci.org/honghaoz/Loggerithm.svg?branch=master)](https://travis-ci.org/honghaoz/Loggerithm)
[![Cocoapods Version](https://img.shields.io/cocoapods/v/Loggerithm.svg?style=flat)](http://cocoapods.org/pods/Loggerithm)
[![License](https://img.shields.io/cocoapods/l/Loggerithm.svg?style=flat)](http://cocoapods.org/pods/Loggerithm)
[![Platform](https://img.shields.io/cocoapods/p/Loggerithm.svg?style=flat)](http://cocoapods.org/pods/Loggerithm)

A lightweight Swift logger, uses `print` in Debug and `NSLog` in Production with colourful output.

![](https://raw.githubusercontent.com/honghaoz/Loggerithm/master/Assets/demo.png)

## Why

In Swift, we usually use `print` to log information into console. However, it doesn't log anything in production version. 

Thus we want to use `NSLog` in production but still want the efficiency of `print` in development. (`print` is faster than `NSLog`).

This project started more than half a year ago, named [ZHSwiftLogger](https://github.com/honghaoz/ZHSwiftLogger). At that time, no other Swift loggers provided this functionality. So I developped this logger for my personal usage.

Nowadays, we have more and more great Swift loggers. While, **Loggerithm** is lightweight, pretty straightforward and handy to use.

## Features
- [x] Use `print` in Debug and `NSLog` in Production.
- [x] Formatted output, just like `NSLog`.
- [x] Log level Support.
- [x] Colorful output and color customization.
- [x] Comprehensive Unit Test Coverage.

## Requirements

- iOS 8.0+ / Mac OS X 10.9+
- Xcode 7.0

## Installation

### Cocoapods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

To integrate **Loggerithm** into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

pod 'Loggerithm', '~> 1.3'
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
Once XcodeColors is installed and loaded properly. To let logger automatically turn on, you need to add `"XcodeColors" = "YES"` environment variable to your build scheme.

This can be done in following way:
- Under target selection, click **Edit Scheme...**
- ![](https://raw.githubusercontent.com/honghaoz/Loggerithm/master/Assets/scheme-select.png)
- Under **Arguments** tab, in **Environment Variables**, hit **+** to add a new environment variable with name "XcodeColors" and value "YES".
- ![](https://raw.githubusercontent.com/honghaoz/Loggerithm/master/Assets/environment.png)

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

#### Fields

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
log.verbose("I can use format: %d + %d = %d", args: 1, 1, 2)
```

Results:
![](https://raw.githubusercontent.com/honghaoz/Loggerithm/master/Assets/formatted.png)

### Color Output

#### Switch On/Off
See **Installation**/**Colorful Output Support** for more detail.

You can modify `useColorfulLog` to turn on/off colorful output.
```swift
log.useColorfulLog = false
log.info("Color is turned off.")
log.useColorfulLog = true
log.info("Color is turned on.")
```
Note, If you don't have [XcodeColors](https://github.com/robbiehanson/XcodeColors) plugin installed but leaving `useColorfulLog` turned on, this will result it hidden color setting code to be visible:

```
[fg190,190,190;2015-08-14 16:55:34.075 [Verbose] [ViewController.swift:34] viewDidLoad(): Verbose message...[;
[fg60,161,202;2015-08-14 16:55:34.076 [Debug] [ViewController.swift:35] viewDidLoad(): Debug message...[;
```

#### Color Customization
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
