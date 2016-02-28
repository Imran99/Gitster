//
//  FakeNSFetchedResultsSectionInfo.swift
//  Gitster
//
//  Created by Imran on 27/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import CoreData

class FakeNSFetchedResultsSectionInfo : NSFetchedResultsSectionInfo{
    @objc var numberOfObjects: Int
    @objc var objects: [AnyObject]?
    @objc var name: String
    @objc var indexTitle: String?
    
    init(){
        numberOfObjects = 0
        name = "section"
    }
}
