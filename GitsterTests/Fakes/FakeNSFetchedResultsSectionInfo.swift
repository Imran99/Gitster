//
//  FakeNSFetchedResultsSectionInfo.swift
//  Gitster
//
//  Created by Imran on 27/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import CoreData

class FakeNSFetchedResultsSectionInfo : NSFetchedResultsSectionInfo{
    @objc var numberOfObjects: Int {
        return objects?.count ?? 0
    }
    @objc var objects: [AnyObject]?
    @objc var name: String
    @objc var indexTitle: String?
    
    init(){
        name = "section"
    }
}
