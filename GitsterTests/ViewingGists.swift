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
@testable import Gitster

class ViewingGists: XCTestCase {
    
    var network: FakeNetwork!
    var repositoryViewModel: RepositoryViewModel!
    
    override func setUp() {
        super.setUp()
        network = FakeNetwork()
        network.responses.append([["name": "repo one"], ["name": "repo two"]])
        
        repositoryViewModel = RepositoryViewModel(network: network)
        repositoryViewModel.activate()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShouldLoadGistsOnStart() {
        expect(self.repositoryViewModel.gists.array).to(equal(["repo one", "repo two"]))
        expect(self.network.request).to(equal("https://api.github.com/repositories"))
    }
    
    func testShouldSearchForGists(){
        //arrange
        network.responses.append(["items" : [["name" : "avocados"], ["name": "apples"]] ])
        
        //act
        repositoryViewModel.searchTerm.value = "a"
        
        //assert
        expect(self.repositoryViewModel.gists.array).to(equal(["avocados","apples"]))
    }
    
    func testShouldRefineSearchAsTyping(){
        network.responses.append(["items" : [["name" : "avocados"], ["name": "apples"]] ])
        network.responses.append(["items" : [["name" : "apples"]] ])
        
        repositoryViewModel.searchTerm.value = "a"
        repositoryViewModel.searchTerm.value = "ap"
        
        expect(self.repositoryViewModel.gists.array).to(equal(["apples"]))
    }
    
    //todo multiword search
    //todo no response
    //todo swiftyjson?
}