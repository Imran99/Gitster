//
//  ManagedObjectContextBuilder.swift
//  Gitster
//
//  Created by Imran on 27/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import CoreData

class ManagedObjectContextBuilder{
    
    func build() -> NSManagedObjectContext{
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