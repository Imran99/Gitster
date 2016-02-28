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
    var tableView: FakeTableView!
    var expectedOperations: [TableOperation]!
    
    override func setUp() {
        super.setUp()
        
        let context = ManagedObjectContextBuilder().Build()
        let message = NSEntityDescription.insertNewObjectForEntityForName("Message", inManagedObjectContext: context) as! Message
        message.text = "hello world"
        
        fetchController = FakeFetchedResultsController()
        fetchController.items = [[message]]
        
        dataSource = BindableDataSource.MessageDataSource(fetchController)

        tableView = FakeTableView()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: String(UITableViewCell))
        
        expectedOperations = []
        
        dataSource.bindTo(tableView) { (indexPath, array, tableView) -> UITableViewCell in
            let cell = tableView.dequeueReusableCellWithIdentifier(String(UITableViewCell), forIndexPath: indexPath)
            return cell
        }
        
        expectedOperations.append(.ReloadData)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //todo test sections
    //todo test through test tableview
    func testShouldReturnRequestedItem(){
        let result = dataSource[0,0]
        
        expect(result).to(equal("hello world"))
    }
    
    func testShouldReloadTableViewOnBind(){
        expect(self.tableView.operations).to(equal(expectedOperations))
    }
}