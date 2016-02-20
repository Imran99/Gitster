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
        network.responses.append([["name": "repo one"], ["name": "repo two"]])
        
        gistsViewModel = GistsViewModel(network: network)
        gistsViewModel.activate()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShouldLoadGistsOnStart() {
        expect(self.gistsViewModel.gists.array).to(equal(["repo one", "repo two"]))
        expect(self.network.request).to(equal("https://api.github.com/repositories"))
    }
    
    func testShouldSearchForGists(){
        //arrange
        network.responses.append(["items" : [["name" : "apples"]] ])
        
        //act
        gistsViewModel.searchTerm.value = "a"
        
        //assert
        expect(self.gistsViewModel.gists.array).to(equal(["apples"]))
    }
    
    //todo refine search as you type
    //todo multiword search
    //todo no response
    //todo swiftyjson?
}