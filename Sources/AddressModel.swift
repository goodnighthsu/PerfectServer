//
//  AddressModel.swift
//  CRM
//
//  Created by 徐非 on 16/12/9.
//  Copyright © 2016年 翼点网络. All rights reserved.
//

import Foundation

class AddressModel: NSObject {
    var sid: String?
    var name: String?
    var mobile: String?
    var province: String?
    var city: String?
    var district: String?
    var address: String?
    var country: String?
    var area: String?       //省 市 区
    
    //Area Description
    func areaDesc() -> String?{
        guard let _ = province, let _ = city, let _ = district else {
            return nil
        }
        
        return "\(province!) \(city!) \(district!)"
    }

}
