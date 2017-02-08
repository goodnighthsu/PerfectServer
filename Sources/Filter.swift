//
//  Filter.swift
//  PerfectServer
//
//  Created by 徐非 on 17/2/6.
//
//

import Foundation
import PerfectHTTP

class Filter{
    struct filter404: HTTPResponseFilter{
        func filterBody(response: HTTPResponse, callback: (HTTPResponseFilterResult) -> ()) {
            callback(.continue)
        }
        
        func filterHeaders(response: HTTPResponse, callback: (HTTPResponseFilterResult) -> ()) {
            if case .notFound = response.status {
                response.setBody(string: "Hi, the file \(response.request.path) was not found.")
                response.setHeader(.contentLength, value: "\(response.bodyBytes.count)")
                callback(.done)
            } else {
                callback(.continue)
            }
        }
        
    }
}
