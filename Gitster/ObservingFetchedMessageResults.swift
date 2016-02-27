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
    
    var dataSource: DataSource<String>!
    var fetchController: FakeFetchedResultsController!
    
    override func setUp() {
        super.setUp()
        fetchController = FakeFetchedResultsController()
        let context = setUpInMemoryManagedObjectContext()
        let message = NSEntityDescription.insertNewObjectForEntityForName("Message", inManagedObjectContext: context) as! Message
        message.text = "hello world"
        fetchController.items = [[message]]
        
        dataSource = DataSource(fetchController: fetchController)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShouldReturnRequestedItem(){
        let result = dataSource[0,0]
        
        expect(result).to(equal("hello world"))
    }
    
    func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext {
        let managedObjectModel = NSManagedObjectModel.mergedModelFromBundles([NSBundle.mainBundle()])!
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        do {
            try persistentStoreCoordinator.addPersistentStoreWithType(NSInMemoryStoreType, configuration: nil, URL: nil, options: nil)
        } catch {
            print("Adding in-memory persistent store coordinator failed")
        }
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType:
            NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        return managedObjectContext
    }
}