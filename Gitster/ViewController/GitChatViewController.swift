//
//  GitChatViewController.swift
//  Gitster
//
//  Created by Imran on 23/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import UIKit
import Bond

class GitChatViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0)
        
        let viewModel = GitChatViewModel(context: Database.context)
        viewModel.messages
            .bindTo(self.tableView){ indexPath, dataSource, tableView in
                let cell = tableView.dequeueReusableCellWithIdentifier(String(UITableViewCell))!
                cell.textLabel?.text = dataSource[indexPath.section, indexPath.row]

                return cell
        }
        
        
    }
}