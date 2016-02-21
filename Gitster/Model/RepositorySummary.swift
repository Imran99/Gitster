//
//  RepositorySummary.swift
//  Gitster
//
//  Created by Imran on 21/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

struct RepositorySummary{
    let name: String
    let url: String
}

extension RepositorySummary : Equatable{}

func ==(lhs: RepositorySummary, rhs: RepositorySummary) -> Bool{
    return lhs.name == rhs.name && lhs.url == rhs.url
}