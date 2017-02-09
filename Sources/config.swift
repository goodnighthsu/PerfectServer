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
    let rootDirectory = "/home/perfectServer/"
    let documentRoot = "/home/perfectServer/webroot"
#else
    let rootDirectory = NSHomeDirectory() + "/perfectServer"
    let documentRoot = "./webroot"
#endif

let logDirectory = rootDirectory + "/log"
let logFile = logDirectory + "/perfectLog.log"
