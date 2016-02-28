//
//  Chatting.swift
//  Gitster
//
//  Created by Imran on 28/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import XCTest
import Nimble
import CoreData
@testable import Gitster

class Chatting: XCTestCase{
    var viewModel: GitChatViewModel!
    var messageBuilder: MessageBuilder!
    var context: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        context = ManagedObjectContextBuilder().build()

        messageBuilder = MessageBuilder().with(context)
        messageBuilder.with("hello today!").sentToday().build()
        messageBuilder.with("hello yesterday!").sentYesterday().build()
        saveContext()
        
        viewModel = GitChatViewModel(context: context)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShouldLoadExistingChatInDateOrder(){
        let data = viewModel.messages.data!
        
        expect(data).to(equal(["hello yesterday!", "hello today!"]))
    }
    
    //todo test failing
    /*func testShouldReceiveNewChats(){
        messageBuilder.with("new message").sentToday().build()
        saveContext()
        
        let data = viewModel.messages.data
        
        expect(data).to(equal(["hello yesterday!", "hello today!", "new message"]))
    }*/
    
    func saveContext(){
        do{
            try context.save()
        }catch{
            fatalError("test: \(error)")
        }
    }
}