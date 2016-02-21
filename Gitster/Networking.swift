//
//  Networking.swift
//  Gister
//
//  Created by Imran on 19/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public protocol Networking{
    func request(url: String, paramaters: [String:String], response: JSON->())
}

class Network : Networking{
    func request(url: String, paramaters: [String:String], response: JSON->()) {
        Alamofire
            .request(.GET, url, parameters: paramaters)
            .responseJSON{ r in
                
                switch r.result {
                case .Success(let data):
                    response(JSON(data))
                case .Failure(let error):
                    print(error)
                }
        }
    }
}