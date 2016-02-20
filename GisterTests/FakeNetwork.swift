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
    
    var response: AnyObject!
    private(set) var request: String?
    
    func request(request: String, response: AnyObject?->()){
        self.request = request
        response(self.response)
    }
}