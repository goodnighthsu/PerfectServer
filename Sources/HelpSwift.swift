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
            let number = self.toInt() ?? 0
            return number
        }
    }
}
