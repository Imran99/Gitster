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
import SwiftyJSON
@testable import Gitster

class FakeNetwork : Networking{
    
    var responses = [JSON]()
    private(set) var request: String?
    private(set) var requestParams: [String:String]?
    
    private var requestCount = 0;
    
    func request(url: String, paramaters: [String:String], response: JSON->()) {
        self.request = url
        self.requestParams = paramaters
        let cannedResponse = responses[requestCount]
        response(cannedResponse)
        requestCount++
    }
}