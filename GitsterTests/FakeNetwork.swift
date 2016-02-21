//
//  FakeNetwork.swift
//  Gister
//
//  Created by Imran on 20/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import XCTest
import Alamofire
import Bond
import Nimble
@testable import Gitster

class FakeNetwork : Networking{
    
    var responses = [AnyObject]()
    private(set) var request: String?
    private(set) var requestParams: [String:String]?
    
    private var requestCount = 0;
    
    func request(request: String, paramaters: [String:String], response: AnyObject?->()){
        self.request = request
        self.requestParams = paramaters
        let cannedResponse = responses[requestCount]
        response(cannedResponse)
        requestCount++
    }
}