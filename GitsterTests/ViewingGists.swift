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
    var gitSearchViewModel: GitSearchViewModel!
    
    override func setUp() {
        super.setUp()
        network = FakeNetwork()
        network.responses.append([["name": "repo one"], ["name": "repo two"]])
        
        gitSearchViewModel = GitSearchViewModel(network: network)
        gitSearchViewModel.activate()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShouldLoadDefaultPublicReposOnStart() {
        expect(self.gitSearchViewModel.gists.array).to(equal(["repo one", "repo two"]))
        expect(self.network.request).to(equal("https://api.github.com/repositories"))
    }
    
    func testShouldSearchWhenThreeCharactersOrMoreEntered(){
        //arrange
        network.responses.append(["items" : [["name" : "apple martini"], ["name": "apples"]] ])
        
        //act
        gitSearchViewModel.searchTerm.value = "app"
        
        //assert
        expect(self.gitSearchViewModel.gists.array).to(equal(["apple martini","apples"]))
    }
    
    
    func testShouldIgnoreSearchTermsLessThanThreeCharacters(){
        network.responses.append(["items" : [["name" : "avocados"], ["name": "apples"]] ])
        
        gitSearchViewModel.searchTerm.value = "ap"
        
        expect(self.gitSearchViewModel.gists.array).to(equal(["repo one", "repo two"]))
    }
    
    func testShouldRefineSearchWhilstTyping(){
        network.responses.append(["items" : [["name" : "abc"], ["name": "abcd"]] ])
        network.responses.append(["items" : [["name" : "abcd"]] ])
        
        gitSearchViewModel.searchTerm.value = "abc"
        gitSearchViewModel.searchTerm.value = "abcd"
        
    expect(self.gitSearchViewModel.gists.array).to(equal(["abcd"]))
        expect(self.network.request).to(equal("https://api.github.com/search/repositories?q=abcd"))
    }
    
    func testShouldNotDisplayAnythingWhenNoMatchingRepositories(){
        network.responses.append(["items" : [] ])
        
        gitSearchViewModel.searchTerm.value = "nonecalledthis"
        
        expect(self.gitSearchViewModel.gists.array).to(beEmpty())
    }
    
    func testShouldNotDisplayResultsIfResponseIsUnexpected(){
        network.responses.append([])
        
        gitSearchViewModel.searchTerm.value = "abcd"
        
        expect(self.gitSearchViewModel.gists.array).to(equal(["Oops! Check the log for details."]))
    }
    
    func testShouldNotDisplayResultsIfItemResponseIsUnexpected(){
        network.responses.append(["items" : "somethingbad" ])
        
        gitSearchViewModel.searchTerm.value = "abcd"
        
        expect(self.gitSearchViewModel.gists.array).to(equal(["Oops! Check the log for details."]))
    }
    
    func testShouldAllowMultiwordSearch(){
        network.responses.append(["items" : [["name" : "apple martini"]] ])
        
        gitSearchViewModel.searchTerm.value = "apple m"
        
        expect(self.gitSearchViewModel.gists.array).to(equal(["apple martini"]))
    }
    
    //todo swiftyjson?
}