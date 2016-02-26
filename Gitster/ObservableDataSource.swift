//
//  ObservableDataSource.swift
//  Gitster
//
//  Created by Imran on 23/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import Bond
import CoreData

public protocol FetchedResultsControllerType{
    func objectAtIndexPath(indexPath: NSIndexPath) -> AnyObject
    weak var delegate: NSFetchedResultsControllerDelegate? {get set}
}

extension NSFetchedResultsController : FetchedResultsControllerType{
}

class MessageDataSource {
    
    private let dataSource: FetchedResultsControllerType
    
    init(dataSource: FetchedResultsControllerType){
        self.dataSource = dataSource
    }
    
    subscript(section: Int, row: Int) -> String{
        let message = dataSource.objectAtIndexPath(NSIndexPath(forRow: row, inSection: section)) as! Message;
        
        return message.text!
    }
}