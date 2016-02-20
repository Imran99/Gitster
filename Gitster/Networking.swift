//
//  Networking.swift
//  Gister
//
//  Created by Imran on 19/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import Foundation
import Alamofire

public protocol Networking{
    func request(url: String, response: AnyObject?->())
}

//todo error handling
class Network : Networking{
    func request(url: String, response: AnyObject?->()) {
        Alamofire
            .request(.GET, url, parameters: ["foo": "bar"], headers: ["auth": "token"])
            .responseJSON(completionHandler: { r in
                response(r.result.value)
            })
    }
}