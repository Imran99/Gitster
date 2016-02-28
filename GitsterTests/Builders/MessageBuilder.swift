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
    private var date = NSDate()
    
    init(){
    }
    
    func with(context: NSManagedObjectContext) -> MessageBuilder{
        self.context = context
        return self
    }
    
    func with(message: String) -> MessageBuilder{
        self.message = message
        return self
    }
    
    func with(date: NSDate)->MessageBuilder{
        self.date = date;
        return self;
    }
    
    func sentToday()->MessageBuilder{
        date = NSDate();
        return self;
    }
    
    func sentYesterday()->MessageBuilder{
        let today: NSDate = NSDate()
        let dateComponents: NSDateComponents = NSDateComponents()
        dateComponents.day = -1
        
        let gregorianCalendar: NSCalendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
        let yesterdayDate: NSDate = gregorianCalendar.dateByAddingComponents(dateComponents, toDate: today, options:NSCalendarOptions(rawValue: 0))!
        
        date = yesterdayDate
        return self;
    }
    
    func build() -> Message{
        let message = NSEntityDescription.insertNewObjectForEntityForName(String(Message), inManagedObjectContext: context) as! Message
        message.text = self.message
        message.date = date
        
        return message
    }
}