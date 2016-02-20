//
//  ViewController.swift
//  Gister
//
//  Created by Imran on 16/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import UIKit
import Bond

class GistsViewController: UITableViewController {

    private let viewModel = GistsViewModel(network: Network())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.gists
            .lift()
            .bindTo(tableView){ indexPath, dataSource, tableView in
            let cell = tableView.dequeueReusableCellWithIdentifier(String(UITableViewCell))!
            cell.textLabel!.text = dataSource[indexPath.section][indexPath.row]
            return cell
        }
        
        viewModel.activate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}