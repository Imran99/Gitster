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
@testable import Gister

class FakeNetwork : Networking{
    
    var responses = [AnyObject]()
    private(set) var request: String?
    
    private var requestCount = 0;
    
    func request(request: String, response: AnyObject?->()){
        self.request = request

        let cannedResponse = responses[requestCount]
        response(cannedResponse)
        requestCount++
    }
}