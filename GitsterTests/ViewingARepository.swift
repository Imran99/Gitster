//
//  ViewingARepository.swift
//  Gitster
//
//  Created by Imran on 21/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import XCTest
import Nimble
@testable import Gitster

class ViewingARepository: XCTestCase {

    var network: FakeNetwork!
    var detailsViewModel: GitDetailsViewModel!
    
    override func setUp() {
        super.setUp()
        network = FakeNetwork()
        network.responses.append([
            "owner":["avatar_url":"someurl"],
            "name":"my repo",
            "description":"this is a repo"
            ])
        
        detailsViewModel = GitDetailsViewModel(network: network, url: "www.example.com")
        detailsViewModel.activate()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testShouldDisplayRepositoryForUrlWithDetails(){
        expect(self.detailsViewModel.name.value).to(equal("my repo"))
        expect(self.detailsViewModel.avatarUrl.value).to(equal("someurl"))
        expect(self.detailsViewModel.description.value).to(equal("this is a repo"))
        expect(self.network.request).to(equal("www.example.com"))
    }
}
