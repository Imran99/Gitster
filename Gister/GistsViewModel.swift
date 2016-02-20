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
        network.request("https://api.github.com/gists", response: { data in
            let json = data as! [[String:AnyObject]]
            json.forEach({self.gists.append($0["description"] as! String)})
        })
    }
}