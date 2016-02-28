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
        
        let index = arc4random_uniform(UInt32(vocabulary.count))
        let message = vocabulary[Int(index)]
            
        Database.saveMessage(message)
    }
    
    private var vocabulary = [
    "are you going to the pub tonight?",
    "did you do a checkin?",
    "whats the weather like?",
    "well i was going to but now i'm not",
    "Android? Who uses Android?",
    "bill says hello",
    ]
}