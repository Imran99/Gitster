//
//  GistsViewModel.swift
//  Gister
//
//  Created by Imran on 16/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import Bond

//todo add a protocol to vm so can stub for ui
class GitSearchViewModel{
    
    let gists = ObservableArray<String>()
    let searchTerm = Observable<String?>(nil)
    
    private let network: Networking
    
    init(network: Networking){
        self.network = network
    }
    
    //todo use insert contents instead
    func activate(){
        network.request("https://api.github.com/repositories", paramaters: [:], response: { data in
            let json = data as! [[String:AnyObject]]
            json.forEach({self.gists.append($0["name"] as! String)})
        })
        
        //todo add params
        searchTerm
            .ignoreNil()
            .filter({$0.characters.count > 2})
            //removed for now to avoid unit test issues
            //.throttle(0.5, queue: Queue.Main)
            .observe({[weak self] in
                let url = "https://api.github.com/search/repositories"
                print(url)
                self?.network.request(url, paramaters: ["q":$0], response: self!.displaySearchResults)
            })
    }
    
    private func displaySearchResults(data: AnyObject?){
        self.gists.removeAll()
        
        let handleError = {
            self.gists.append("Oops! Check the log for details.")
            print(data)
        }
        
        guard let json = data as? [String:AnyObject] else{
            handleError()
            return
        }
        
        guard let items = json["items"] as? [[String:AnyObject]] else{
            handleError()
            return
        }
        
        items.forEach({self.gists.append($0["name"] as! String)})
    }
}