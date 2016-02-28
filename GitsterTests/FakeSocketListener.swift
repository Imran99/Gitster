//
//  SoketListener.swift
//  Gitster
//
//  Created by Imran on 28/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import Foundation
import CoreData

class FakeSocketListener: NSObject {
    
    var timer: NSTimer!
    
    func listen(){
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "chatReceived:", userInfo: nil, repeats: true)
    }
    
    func chatReceived(timer: NSTimer!){
        Database.saveMessage("hello")
    }
}