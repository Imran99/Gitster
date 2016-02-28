//
//  MessageBuilder.swift
//  Gitster
//
//  Created by Imran on 28/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import Foundation
import CoreData

class MessageBuilder {

    private var context: NSManagedObjectContext!
    private var message = "hello world"
    
    init(){
    }
    
    func With(context: NSManagedObjectContext) -> MessageBuilder{
        self.context = context
        return self
    }
    
    func With(message: String) -> MessageBuilder{
        self.message = message
        return self
    }
    
    func Build() -> Message{
        let message = NSEntityDescription.insertNewObjectForEntityForName("Message", inManagedObjectContext: context) as! Message
        message.text = self.message
        
        return message
    }
}