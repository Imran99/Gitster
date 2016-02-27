//
//  ObservingFetchedResultsController.swift
//  Gitster
//
//  Created by Imran on 26/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import XCTest
import Nimble
import CoreData
@testable import Gitster

class ObservingFetchedMessageResults: XCTestCase {
    
    var dataSource: BindableDataSource<String>!
    var fetchController: FakeFetchedResultsController!
    
    override func setUp() {
        super.setUp()
        
        let context = ManagedObjectContextBuilder().Build()
        let message = NSEntityDescription.insertNewObjectForEntityForName("Message", inManagedObjectContext: context) as! Message
        message.text = "hello world"
        
        fetchController = FakeFetchedResultsController()
        fetchController.items = [[message]]
        
        dataSource = BindableDataSource.MessageDataSource(fetchController)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShouldReturnRequestedItem(){
        let result = dataSource[0,0]
        
        expect(result).to(equal("hello world"))
    }
}