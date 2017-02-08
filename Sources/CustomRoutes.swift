//
//  customRoutes.swift
//  PerfectServer
//
//  Created by 徐非 on 17/2/6.
//
//

import Foundation
import PerfectHTTP

class CustomRoutes{
    class func createRoutes() -> Routes{
        var routes = Routes()
        //MARK: User
//        routes.add(method: .get, uri: "/user/{id}", handler: UserModel.detail)
        routes.add(method: .get, uri:"/user", handler: userList)
//        routes.add(method: .post, uri:"/login", handler: UserModel.login)
        
        return routes
    }
    
    static let userList: RequestHandler = { req, res in
        res.validate()
        res.output("user")
        res.completed()
    }

}

