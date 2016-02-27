//
//  ObservableDataSource.swift
//  Gitster
//
//  Created by Imran on 23/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import Foundation

class BindableDataSource<T> {
    typealias map = AnyObject -> T

    private let fetchController: FetchedResultsControllerType
    private let mapper: map
    
    init(fetchController: FetchedResultsControllerType, mapper: map){
        self.fetchController = fetchController
        self.mapper = mapper
    }
    
    subscript(section: Int, row: Int) -> T{
        let object = fetchController.objectAtIndexPath(NSIndexPath(forRow: row, inSection: section));
        let mapped = mapper(object)
        
        return mapped
    }
}