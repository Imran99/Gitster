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

class SearchingGit: XCTestCase {
    
    var network: FakeNetwork!
    var gitSearchViewModel: GitSearchViewModel!
    
    override func setUp() {
        super.setUp()
        network = FakeNetwork()
        network.responses.append([
            ["name": "repo one", "url":"url one"],
            ["name": "repo two", "url":"url two"]])
        
        gitSearchViewModel = GitSearchViewModel(network: network)
        gitSearchViewModel.activate()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShouldLoadDefaultPublicReposOnStart() {
        let expected = [
            RepositorySummary(name: "repo one", url: "url one"),
            RepositorySummary(name: "repo two", url: "url two")]
        expect(self.gitSearchViewModel.gists.array).to(equal(expected))
        expect(self.network.request).to(equal("https://api.github.com/repositories"))
    }
    
    func testShouldSearchWhenThreeCharactersOrMoreEntered(){
        //arrange
        network.responses.append(["items" : [
            ["name" : "apple martini", "url":"url one"],
            ["name": "apples", "url":"url two"]
            ]])
        
        //act
        gitSearchViewModel.searchTerm.value = "app"
        
        //assert
        let expected = [
            RepositorySummary(name: "apple martini", url: "url one"),
            RepositorySummary(name: "apples", url: "url two")]
        expect(self.gitSearchViewModel.gists.array).to(equal(expected))
        expect(self.network.request).to(equal("https://api.github.com/search/repositories"))
        expect(self.network.requestParams).to(equal(["q":"app"]))
    }
    
    
    func testShouldIgnoreSearchTermsLessThanThreeCharacters(){
        network.responses.append(["items" : [
            ["name" : "avocados"],
            ["name": "apples"]
            ]])
        
        gitSearchViewModel.searchTerm.value = "ap"
        
        let expected = [
            RepositorySummary(name: "repo one", url: "url one"),
            RepositorySummary(name: "repo two", url: "url two")]
        expect(self.gitSearchViewModel.gists.array).to(equal(expected))
    }
    
    func testShouldRefineSearchWhilstTyping(){
        network.responses.append(["items" : [
            ["name" : "abc", "url" : "url one"],
            ["name": "abcd", "url":"url two"]
            ]])
        network.responses.append(["items" :[
            ["name" : "abcd","url":"url two"]
            ]])
        
        gitSearchViewModel.searchTerm.value = "abc"
        gitSearchViewModel.searchTerm.value = "abcd"
        
        expect(self.gitSearchViewModel.gists.array).to(equal([RepositorySummary(name: "abcd", url: "url two")]))
    }
    
    func testShouldNotDisplayAnythingWhenNoMatchingRepositories(){
        network.responses.append(["items" : [] ])
        
        gitSearchViewModel.searchTerm.value = "nonecalledthis"
        
        expect(self.gitSearchViewModel.gists.array).to(beEmpty())
    }
    
    func testShouldDisplayLoadingIndicatorWhenSearchInProgress(){
        network.responses.append([["name": "repo one", "url":"url one"]])
        var didDisplayLoadingIndicator = false
        gitSearchViewModel.searchInProgress.observe{_ in didDisplayLoadingIndicator = true}
        
        gitSearchViewModel.searchTerm.value = "search"
        expect(didDisplayLoadingIndicator).toEventually(equal(true), timeout: 1)
    }
    
    func testShouldNotDisplayResultsIfResponseIsUnexpected(){
        network.responses.append([])
        
        gitSearchViewModel.searchTerm.value = "abcd"
        
        expect(self.gitSearchViewModel.gists.array).to(beEmpty())
    }
    
    func testShouldNotDisplayResultsIfItemResponseIsUnexpected(){
        network.responses.append(["items" : "somethingbad" ])
        
        gitSearchViewModel.searchTerm.value = "abcd"
        
        expect(self.gitSearchViewModel.gists.array).to(beEmpty())
    }
    
    func testShouldDisplayErrorOnSearchWhenRateLimitExceeded(){
        network.responses.append(["message" : "some error" ])
        var error = [String]()
        self.gitSearchViewModel.error.observe{error.append($0)}
        
        gitSearchViewModel.searchTerm.value = "abcd"
        
        expect(error).toEventually(equal(["some error"]), timeout: 1)
        expect(self.gitSearchViewModel.gists.array).to(beEmpty())
    }
    
    func testShouldDisplayErrorOnStartWhenRateLimitExceeded(){
        network = FakeNetwork()
        network.responses.removeAll()
        network.responses.append(["message" : "some error" ])
        var error = [String]()
        gitSearchViewModel = GitSearchViewModel(network: network)
        self.gitSearchViewModel.error.observe{error.append($0)}

        gitSearchViewModel.activate()
        
        expect(error).toEventually(equal(["some error"]), timeout: 1)
        expect(self.gitSearchViewModel.gists.array).to(beEmpty())
    }
}