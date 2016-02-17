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
        XCTAssertEqual(["bob", "clive"], gistsViewModel.gists.array)
    }
}
