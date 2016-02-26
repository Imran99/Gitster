//
//  FakeFetchedResultsController.swift
//  Gitster
//
//  Created by Imran on 26/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import CoreData

class FakeFetchedResultsController : FetchedResultsControllerType{
    var items = [[AnyObject]]()
    weak var delegate: NSFetchedResultsControllerDelegate?
    
    func objectAtIndexPath(indexPath: NSIndexPath) -> AnyObject{
        return items[indexPath.section][indexPath.row]
    }
}