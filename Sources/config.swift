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

//MAKR: MySql
#if os(Linux)
let mySqlHost = "127.0.0.1"
let mySqlUserName = "root"
let mySqlPassword = "Wxgoogle123"
let mySqlDatabase = "crm_0223"
let mySqlPort = 3306
#else
let mySqlHost = "127.0.0.1"
let mySqlUserName = "root"
let mySqlPassword = "a123456"
let mySqlDatabase = "crm_0223"
let mySqlPort = 3306
#endif
