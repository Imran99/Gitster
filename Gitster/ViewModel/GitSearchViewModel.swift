//
//  GistsViewModel.swift
//  Gister
//
//  Created by Imran on 16/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import Bond
import SwiftyJSON

//todo add a protocol to vm so can stub for ui
class GitSearchViewModel{
    
    let gists = ObservableArray<RepositorySummary>()
    let searchTerm = Observable<String?>(nil)
    let error = EventProducer<String>()
    let searchInProgress = Observable<Bool>(false)
    
    private let network: Networking
    
    init(network: Networking){
        self.network = network
    }
    
    //todo use insert contents instead
    func activate(){
        network.request("https://api.github.com/repositories", paramaters: [:], response: { json in
            self.handleIfError(json)
            json.forEach{ _, child in
                if let name = child["name"].string, let url = child["url"].string{
                    self.gists.append(RepositorySummary(name:name, url:url))
                }
            }
        })
        
        searchTerm
            .ignoreNil()
            .filter({$0.characters.count > 2})
            //removed for now to avoid unit test issues
            //.throttle(0.5, queue: Queue.Main)
            .observe({[weak self] in
                self?.searchInProgress.next(true)
                let url = "https://api.github.com/search/repositories"
                print(url)
                self?.network.request(url, paramaters: ["q":$0], response: self!.displaySearchResults)
            })
    }
    
    private func displaySearchResults(json: JSON){
        searchInProgress.next(false)
        self.gists.removeAll()
        handleIfError(json)
        json["items"].forEach{ _, child in
            if let name = child["name"].string, let url = child["url"].string{
                self.gists.append(RepositorySummary(name:name, url:url))
            }
        }
    }
    
    private func handleIfError(json: JSON){
        guard let message = json["message"].string else{
            return
        }
        print(message)
        error.next(message)
    }
}