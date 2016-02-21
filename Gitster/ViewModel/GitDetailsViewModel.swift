//
//  GitDetailsViewModel.swift
//  Gitster
//
//  Created by Imran on 21/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import Bond
import SwiftyJSON

class GitDetailsViewModel {
    
    let name = Observable<String>("")
    let description = Observable<String>("")
    let avatarUrl = Observable<String>("")
    
    private let network: Networking
    
    init(network: Networking){
        self.network = network
    }
    
    func activate(){
        network.request("requesturl", paramaters: [:]){ json in
            self.name.next(json["name"].stringValue)
            self.avatarUrl.next(json["owner"]["avatar_url"].stringValue)
            self.description.next(json["description"].stringValue)
        }
    }
}