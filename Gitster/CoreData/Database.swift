//
//  Database.swift
//  Gitster
//
//  Created by Imran on 28/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import CoreData

class Database{
    
    static let persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let managedObjectModel = NSManagedObjectModel.mergedModelFromBundles([NSBundle.mainBundle()])!
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let storeURL = (urls[urls.endIndex-1]).URLByAppendingPathComponent("gitster.sqlite")
        
        do {
            try persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
        } catch {
            print("Adding persistent store failed")
        }
        
        return persistentStoreCoordinator
    }()
    
    static let context: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType:
            NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        
        return context;
    }()
    
    class func saveMessage(text: String){
        let message = NSEntityDescription.insertNewObjectForEntityForName(String(Message), inManagedObjectContext: context) as! Message
        message.text = text
        message.date = NSDate()
        
        do{
            try context.save()
        }catch{
            fatalError("\(error)")
        }
    }
}