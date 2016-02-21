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
    func request(url: String, paramaters: [String:String], response: AnyObject?->())
}

//todo error handling
//todo headers
//todo params
class Network : Networking{
    func request(url: String, paramaters: [String:String], response: AnyObject?->()) {
        Alamofire
            .request(.GET, url, parameters: paramaters)
            .responseJSON(completionHandler: { r in
                
                switch r.result {
                case .Success(let data):
                    response(data)
                case .Failure(let error):
                    print(error)
                }
            })
    }
}