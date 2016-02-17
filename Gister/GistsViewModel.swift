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
    
    func activate(){
        gists.append("bob")
        gists.append("clive")
    }
}