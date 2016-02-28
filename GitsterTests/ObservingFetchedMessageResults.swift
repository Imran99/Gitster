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
    let messageBuilder = MessageBuilder()
    
    override func setUp() {
        super.setUp()
        
        let context = ManagedObjectContextBuilder().Build()
        messageBuilder.With(context)
        let messageOne = messageBuilder.With("message one").Build()
        let messageTwo = messageBuilder.With("message two").Build()
        
        fetchController = FakeFetchedResultsController()
        fetchController.appendSection()
        fetchController.append(0, item: messageOne)
        fetchController.append(0, item: messageTwo)
        
        tableView = FakeTableView()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: String(UITableViewCell))

        dataSource = BindableDataSource.MessageDataSource(fetchController)
        dataSource.bindTo(tableView) { (indexPath, array, tableView) -> UITableViewCell in
            let cell = tableView.dequeueReusableCellWithIdentifier(String(UITableViewCell), forIndexPath: indexPath)
            return cell
        }
        
        expectedOperations = []
        expectedOperations.append(.ReloadData)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //todo test sections
    //todo test through test tableview
    //todo load data in tableview on first bind
    func testShouldReturnRequestedItem(){
        let result = dataSource[0,1]
        
        expect(result).to(equal("message two"))
    }
    
    func testShouldReloadTableViewOnBind(){
        expect(self.tableView.operations).to(equal(expectedOperations))
    }
    
    func testShouldInsertARowWhenDataSourceInsertsARow(){
        let message = messageBuilder.With("inserted item").Build()
        fetchController.append(0, item: message)
        
        expectedOperations.append(.InsertRows([NSIndexPath(forItem: 2, inSection: 0)]))
        expect(self.tableView.operations).to(equal(expectedOperations))
    }
    
    func testShouldDeleteARowWhenDataSourceDeletesARow(){
        fetchController.delete(0, row: 1)
        
        expectedOperations.append(.DeleteRows([NSIndexPath(forItem: 1, inSection: 0)]))
        expect(self.tableView.operations).to(equal(expectedOperations))
    }
    
    func testShouldUpdateARowWhenDataSourceUpdatesARow(){
        let message = messageBuilder.With("updated item").Build()
        fetchController.update(0, row: 1, item: message)
        
        expectedOperations.append(.ReloadRows([NSIndexPath(forItem: 1, inSection: 0)]))
        expect(self.tableView.operations).to(equal(expectedOperations))
    }
}