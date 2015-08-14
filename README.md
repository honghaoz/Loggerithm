# Loggerithm

A lightweight Swift logger, uses `println` in Debug and `NSLog` in Production with colourful output.

![](https://raw.githubusercontent.com/honghaoz/ZHSwiftLogger/master/Assets/demo.png)

## Why

There's a lot of great libraries for logging, like [CocoaLumberjack](https://github.com/CocoaLumberjack/CocoaLumberjack),
[XCGLogger](https://github.com/DaveWoodCom/XCGLogger),
[Swell](https://github.com/hubertr/Swell)

However, the problems are:

- CocoaLumberjack is not for Swift and it's not lightweight

- XCGLogger and Swell are only using `println()`, which is efficient for debugging but not actually logging anything (In production, we still need `NSLog` to log out informations)

And **Loggerithm** is clear and very handy to use.

## Installation

### Cocoapods

TODO

### Manually
- Add Swift files in **Source** folder into your project

- Add `DEBUG` flag to Swift Compiler:
  - Open project setting
  - Select your target
  - Go to `Build Settings`
  - Search `Swift`
  - Under **Swift Compiler - Custom Flags** section, in **Other Swift Flags** line, add `-D DEBUG`
![](https://raw.githubusercontent.com/honghaoz/ZHSwiftLogger/master/Preview/debugSetting.png)

## Usage

### Basic 
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
<div style="width: 125%; background-color: #2B3644; font-family: Consolas, Menlo, Monaco, Lucida Console, Liberation Mono, DejaVu Sans Mono, Bitstream Vera Sans Mono, Courier New, monospace, serif;">
<span style="color: #CACACA; font-size: 14px">2015-08-13 23:26:24.500 [Verbose] [ViewController.swift:30] viewDidLoad(): Verbose message...</span><br/>
<span style="color: #4DB1D4; font-size: 14px">2015-08-13 23:26:24.501 [Debug] [ViewController.swift:31] viewDidLoad(): Debug message...</span><br/>
<span style="color: #F6C703; font-size: 14px">2015-08-13 23:26:24.501 [Info] [ViewController.swift:32] viewDidLoad(): Info message...</span><br/>
<span style="color: #F18E16; font-size: 14px">2015-08-13 23:26:24.501 [Warning] [ViewController.swift:33] viewDidLoad(): Warning message...</span><br/>
<span style="color: #EC2B1D; font-size: 14px">2015-08-13 23:26:24.501 [Error] [ViewController.swift:34] viewDidLoad(): Error message...</span><br/>
</div>

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

Log string containts 5 fields, formart is:

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
<div style="width: 125%; background-color: #2B3644; font-family: Consolas, Menlo, Monaco, Lucida Console, Liberation Mono, DejaVu Sans Mono, Bitstream Vera Sans Mono, Courier New, monospace, serif;">
<span style="color: #F6C703; font-size: 14px">[Info] [ViewController.swift:38] viewDidLoad(): date time is turned off.</span><br/>
<span style="color: #F6C703; font-size: 14px">[Info] [ViewController.swift] viewDidLoad(): Line number is turned off.</span><br/>
<span style="color: #F6C703; font-size: 14px">[Info] viewDidLoad(): File name is turned off.</span><br/>
<span style="color: #F6C703; font-size: 14px">[Info]: Function name is turned off.</span><br/>
<span style="color: #F6C703; font-size: 14px">Log level is turned off.</span><br/>
</div>

#### Formatted Output

```swift
var log = Loggerithm()
log.verboseWithFormat("I can use format: %d + %d = %d", args: 1, 1, 2)
```

Results:
<div style="width: 125%; background-color: #2B3644; font-family: Consolas, Menlo, Monaco, Lucida Console, Liberation Mono, DejaVu Sans Mono, Bitstream Vera Sans Mono, Courier New, monospace, serif;">
<span style="color: #F6C703; font-size: 14px">[Info]: I can use format: 1 + 1 = 2</span><br/>
</div>

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
<div style="width: 125%; background-color: #2B3644; font-family: Consolas, Menlo, Monaco, Lucida Console, Liberation Mono, DejaVu Sans Mono, Bitstream Vera Sans Mono, Courier New, monospace, serif;">
<span style="color: #919191; font-size: 14px">2015-08-13 23:26:24.500 [Verbose] [ViewController.swift:30] viewDidLoad(): Verbose message...</span><br/>
<span style="color: #69F900; font-size: 14px">2015-08-13 23:26:24.501 [Debug] [ViewController.swift:31] viewDidLoad(): Debug message...</span><br/>
<span style="color: #FDFB00; font-size: 14px">2015-08-13 23:26:24.501 [Info] [ViewController.swift:32] viewDidLoad(): Info message...</span><br/>
<span style="color: #F08C1E; font-size: 14px">2015-08-13 23:26:24.501 [Warning] [ViewController.swift:33] viewDidLoad(): Warning message...</span><br/>
<span style="color: #EC2B00; font-size: 14px">2015-08-13 23:26:24.501 [Error] [ViewController.swift:34] viewDidLoad(): Error message...</span><br/>
</div>


## Advantages

**Loggerithm** will use `println()` for development and use `NSLog()` for production.

This will be faster when debugging and still have log information for production.

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
