//
//  ViewController.swift
//  Demo
//
//  Created by Honghao Zhang on 2014-12-10.
//  Copyright (c) 2014 HonghaoZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        logVerbose()
        logVerbose("This is verbose message")
        logDebug("This is debug message")
        logVerbose("Turn off DateTime")
        ZHLogShowDateTime = false
        logInfo("Now not date time is logged out")
        logError("I can use format: %d + %d = %d", args: 1, 1, 2)
        logInfo("Not turn off all")
        ZHLogShowFileName = false
        ZHLogShowLineNumber = false
        ZHLogShowFunctionName = false
        logWarning("This is a warning")
    }
}

