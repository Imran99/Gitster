//
//  ViewController.swift
//  Gister
//
//  Created by Imran on 16/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import UIKit
import Bond

class RepositoryViewController: UITableViewController {

    @IBOutlet var searchField: UITextField!
    private let viewModel = RepositoryViewModel(network: Network())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0)
        
        viewModel.gists
            .lift()
            .bindTo(tableView){ indexPath, dataSource, tableView in
                let cell = tableView.dequeueReusableCellWithIdentifier(String(UITableViewCell))!
                cell.textLabel!.text = dataSource[indexPath.section][indexPath.row]
                return cell
        }
        
        viewModel.activate()
        
        searchField.bnd_text
            .bindTo(viewModel.searchTerm)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}