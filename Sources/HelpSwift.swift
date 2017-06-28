//
//  HelpSwift.swift
//  PerfectServer
//
//  Created by 徐非 on 17/2/16.
//
//

import Foundation

extension String{
    //MARK: String to Int
    var intValue: Int {
        get{
            let string = self as NSString
            return Int(string.integerValue)
        }
    }
}
