//
//  GisterTests.swift
//  GisterTests
//
//  Created by Imran on 16/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import XCTest
import Alamofire
import Bond
import Nimble
@testable import Gister

class ViewingGists: XCTestCase {
    
    var network: FakeNetwork!
    var gistsViewModel: GistsViewModel!
    
    override func setUp() {
        super.setUp()
        network = FakeNetwork()
        gistsViewModel = GistsViewModel(network: network)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShouldLoadAGist() {
        //arrange
        network.response = [["name": "bob"], ["name": "clive"]]
        
        //act
        gistsViewModel.activate()
        
        //assert
        expect(self.gistsViewModel.gists.array).to(equal(["bob", "clive"]))
        expect(self.network.request).to(equal("https://api.github.com/gists"))
    }
}

class FakeNetwork : Networking{
    
    var response: AnyObject!
    private(set) var request: String?
    
    func request(request: String, response: AnyObject?->()){
        self.request = request
        response(self.response)
    }
}