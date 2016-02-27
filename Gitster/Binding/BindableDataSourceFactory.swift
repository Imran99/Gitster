//
//  BindableDataSourceFactory.swift
//  Gitster
//
//  Created by Imran on 27/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import Bond

extension BindableDataSource where T:Message{
    
    class func MessageDataSource(fetchController: FetchedResultsControllerType)->BindableDataSource<String>{
        
        let mapper: AnyObject->String = {source in
            let message = source as! Message
            return message.text!
        }
        
        return BindableDataSource<String>(fetchController: fetchController, mapper: mapper)
    }
}