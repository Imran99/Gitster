//
//  FetchedResultControllerType.swift
//  Gitster
//
//  Created by Imran on 27/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import CoreData

public protocol FetchedResultsControllerType{
    func objectAtIndexPath(indexPath: NSIndexPath) -> AnyObject
    var sections: [NSFetchedResultsSectionInfo]? { get }
    weak var delegate: NSFetchedResultsControllerDelegate? {get set}
}

extension NSFetchedResultsController : FetchedResultsControllerType{
}