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
        dataSource.bindTo(tableView) { (indexPath, dataSource, tableView) -> UITableViewCell in
            let cell = tableView.dequeueReusableCellWithIdentifier(String(UITableViewCell), forIndexPath: indexPath)
            cell.textLabel?.text = dataSource[indexPath.section, indexPath.row]
            
            return cell
        }
        
        expectedOperations = []
        expectedOperations.append(.ReloadData)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //todo move rows
    //todo move section
    //todo test sections
    func testShouldLoadCellsOnDemand(){
        let count = tableView.numberOfRowsInSection(0)
        let sectionCount = tableView.numberOfSections
        tableView.scrollToRowAtIndexPath(NSIndexPath(forItem: 1, inSection: 0), atScrollPosition: .Middle, animated: false)
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forItem: 1, inSection: 0))
        
        expect(sectionCount).to(equal(1))
        expect(count).to(equal(2))
        expect(cell!.textLabel!.text).to(equal("message two"))
    }
    
    func testShouldReloadTableViewOnBind(){
        expect(self.tableView.operations).to(equal(expectedOperations))
    }
    
    func testShouldInsertRowWhenDataSourceInsertsARow(){
        let message = messageBuilder.With("inserted item").Build()
        fetchController.append(0, item: message)
        
        expectedOperations.append(.InsertRows([NSIndexPath(forItem: 2, inSection: 0)]))
        expect(self.tableView.operations).to(equal(expectedOperations))
    }
    
    func testShouldDeleteRowWhenDataSourceDeletesARow(){
        fetchController.delete(0, row: 1)
        
        expectedOperations.append(.DeleteRows([NSIndexPath(forItem: 1, inSection: 0)]))
        expect(self.tableView.operations).to(equal(expectedOperations))
    }
    
    func testShouldReloadRowWhenDataSourceUpdatesARow(){
        let message = messageBuilder.With("updated item").Build()
        fetchController.update(0, row: 1, item: message)
        
        expectedOperations.append(.ReloadRows([NSIndexPath(forItem: 1, inSection: 0)]))
        expect(self.tableView.operations).to(equal(expectedOperations))
    }
    
    func testShouldInsertSectionWhenDataSourceInsertsASection(){
        fetchController.appendSection()
        
        expectedOperations.append(.InsertSections(NSIndexSet(index: 1)))
        expect(self.tableView.operations).to(equal(expectedOperations))
    }
    
    func testShouldReloadSectionWhenDataSourceUpdatesSection(){
        fetchController.updateSection(0)
        
        expectedOperations.append(.ReloadSections(NSIndexSet(index: 0)))
        expect(self.tableView.operations).to(equal(expectedOperations))
    }
    
    func testShouldDeleteSectionWhenDataSourceDeletesSection(){
        fetchController.deleteSection(0)
        
        expectedOperations.append(.DeleteSections(NSIndexSet(index: 0)))
        expect(self.tableView.operations).to(equal(expectedOperations))
    }
}