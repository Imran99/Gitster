//
//  GitChatViewModel.swift
//  Gitster
//
//  Created by Imran on 23/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import Foundation
import Bond
import CoreData

class GitChatViewModel{
    
    let messages : BindableDataSource<String>
    
    init(context: NSManagedObjectContext){
        
        let fetch = NSFetchRequest(entityName: String(Message))
        fetch.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        let fetchController = NSFetchedResultsController(fetchRequest: fetch, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        messages = BindableDataSource.MessageDataSource(fetchController)
        
        do{
            try fetchController.performFetch()
        }catch{
            fatalError("chat viewmodel: \(error)")
        }
    }
}