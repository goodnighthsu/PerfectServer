//
//  config.swift
//  PerfectServer
//
//  Created by 徐非 on 17/2/7.
//
//

import Foundation

//MARK: JWT
let JWTSecret = "Leon Perfect"

//MARK: Web
#if os(Linux)
    let rootDirectory = NSHomeDirectory() + "/perfectServer"
#else
    let rootDirectory = NSHomeDirectory() + "/perfectServer"
#endif

let logDirectory = rootDirectory + "/log"
let logFile = logDirectory + "/perfectLog.log"
