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

class DataSource<T> {
    
    private let fetchController: FetchedResultsControllerType
    
    init(fetchController: FetchedResultsControllerType){
        self.fetchController = fetchController
    }
    
    subscript(section: Int, row: Int) -> T{
        let message = fetchController.objectAtIndexPath(NSIndexPath(forRow: row, inSection: section)) as! Message;
        
        return message.text as! T
    }
}