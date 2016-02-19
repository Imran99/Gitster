//
//  GisterTests.swift
//  GisterTests
//
//  Created by Imran on 16/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import XCTest
@testable import Gister
import Bond
import Nimble

class ViewingGists: XCTestCase {
    
    var gistsViewModel: GistsViewModel!
    
    override func setUp() {
        super.setUp()
        gistsViewModel = GistsViewModel()
        gistsViewModel.activate()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShouldLoadAGist() {
        expect(self.gistsViewModel.gists.array).to(equal(["bob", "clive"]))
    }
}
