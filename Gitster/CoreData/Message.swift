//
//  Message.swift
//  Gitster
//
//  Created by Imran on 23/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import Foundation
import CoreData


class Message: NSManagedObject {
}

extension Message {
    
    @NSManaged var text: String?
    @NSManaged var date: NSDate?
    
}
