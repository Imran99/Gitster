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
    
    func testShouldLoadDefaultPublicReposOnStart() {
        expect(self.repositoryViewModel.gists.array).to(equal(["repo one", "repo two"]))
        expect(self.network.request).to(equal("https://api.github.com/repositories"))
    }
    
    func testShouldSearchWhenThreeCharactersOrMoreEntered(){
        //arrange
        network.responses.append(["items" : [["name" : "apple martini"], ["name": "apples"]] ])
        
        //act
        repositoryViewModel.searchTerm.value = "app"
        
        //assert
        expect(self.repositoryViewModel.gists.array).to(equal(["apple martini","apples"]))
    }
    
    
    func testShouldIgnoreSearchTermsLessThanThreeCharacters(){
        network.responses.append(["items" : [["name" : "avocados"], ["name": "apples"]] ])
        
        repositoryViewModel.searchTerm.value = "ap"
        
        expect(self.repositoryViewModel.gists.array).to(equal(["repo one", "repo two"]))
    }
    
    func testShouldRefineSearchWhilstTyping(){
        network.responses.append(["items" : [["name" : "abc"], ["name": "abcd"]] ])
        network.responses.append(["items" : [["name" : "abcd"]] ])
        
        repositoryViewModel.searchTerm.value = "abc"
        repositoryViewModel.searchTerm.value = "abcd"
        
        expect(self.repositoryViewModel.gists.array).to(equal(["abcd"]))
        expect(self.network.request).to(equal("https://api.github.com/search/repositories?q=abcd"))
    }
    
    func testShouldNotDisplayAnythingWhenNoMatchingRepositories(){
        network.responses.append(["items" : [] ])
        
        repositoryViewModel.searchTerm.value = "nonecalledthis"
        
        expect(self.repositoryViewModel.gists.array).to(beEmpty())
    }
    
    func testShouldNotDisplayResultsIfResponseIsUnexpected(){
        network.responses.append([])
        
        repositoryViewModel.searchTerm.value = "abcd"
        
        expect(self.repositoryViewModel.gists.array).to(equal(["Oops something went wrong!"]))
    }
    
    func testShouldNotDisplayResultsIfItemResponseIsUnexpected(){
        network.responses.append(["items" : "somethingbad" ])
        
        repositoryViewModel.searchTerm.value = "abcd"
        
        expect(self.repositoryViewModel.gists.array).to(equal(["Oops something went wrong!"]))
    }
    
    //todo swiftyjson?
}