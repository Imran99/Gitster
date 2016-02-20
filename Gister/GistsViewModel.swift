//
//  GistsViewModel.swift
//  Gister
//
//  Created by Imran on 16/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import Bond

public class GistsViewModel{
    
    let gists = ObservableArray<String>()
    let network: Networking
    
    public init(network: Networking){
        self.network = network
    }
    
    func activate(){
        network.request("https://api.github.com/gists", response: { data in
            let json = data as! [[String:String]]
            json.forEach({self.gists.append($0["name"]!)})
        })
    }
}