//
//  RequestOutput.swift
//  PerfectServer
//
//  Created by 徐非 on 17/2/6.
//
//

import Foundation
import PerfectLib
import PerfectHTTP
import JWT

extension HTTPResponse{
    //格式化输出
    func output(_ obj: Any) {
        self.setHeader(.contentType, value: "application/json")
        let resultDic: [String: Any] = ["code": 1, "result":obj]
        do {
            let jsonString = try resultDic.jsonEncodedString()
            self.appendBody(string: jsonString)
        }catch{
            self.outputError(error.localizedDescription)
        }
        
        self.completed()
    }
    
    //输出Error
    func outputError(_ message: String, code: Int =  0){
        self.setHeader(.contentType, value: "application/json")
        let errorDic: [String: Any] = ["code": code, "msg": message]
        do {
            let jsonString = try errorDic.jsonEncodedString()
            self.appendBody(string: jsonString)
        }catch{
            print("Decode error: \(error)")
        }
        
        self.completed()
    }
    
    //鉴权
    func validate(){
        print(self.request.cookies)
        let cookies = self.request.cookies
        var tokenValue: String?
        for (name, value) in cookies{
            if name == "token" {
                tokenValue = value
            }
        }
        //没有token
        guard let token = tokenValue else{
            self.status = .unauthorized
            self.completed()
            return
        }
        
        //token 解析
        do {
            let claims:ClaimSet = try decode(token, algorithm: .hs256(JWTSecret.data(using: .utf8)!), verify: true, audience: nil, issuer: nil)
//            let claims = decode(token,algorithm: .hs256(JWTSecret.data(using: .utf8)!), verify: true, audience: nil, issuer: nil)
            
            print(claims)
        }catch{
            self.status = .unauthorized
            self.completed()
        }
    }
}

extension HTTPRequest{

}
