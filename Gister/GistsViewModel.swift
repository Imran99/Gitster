//
//  GistsViewModel.swift
//  Gister
//
//  Created by Imran on 16/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import Bond

//todo add a protocol to vm so can stub for ui
public class GistsViewModel{
    
    let gists = ObservableArray<String>()
    let searchTerm = Observable<String?>(nil)
    
    private let network: Networking
    
    public init(network: Networking){
        self.network = network
    }
    
    func activate(){
        network.request("https://api.github.com/repositories", response: { data in
            let json = data as! [[String:AnyObject]]
            json.forEach({self.gists.append($0["name"] as! String)})
        })
        
        //todo add params
        searchTerm
            .ignoreNil()
            .observe({
            self.network.request("https://api.gtihub.com/search/repositories?q=" + $0, response: { data in
                let json = data as! [String:AnyObject]
                let items = json["items"] as! [[String:AnyObject]]
                self.gists.removeAll()
                items.forEach({self.gists.append($0["name"] as! String)})
            })
        })
    }
}