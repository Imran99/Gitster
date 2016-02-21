//
//  ViewController.swift
//  Gister
//
//  Created by Imran on 16/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import UIKit
import Bond

class GitSearchViewController: UITableViewController {

    @IBOutlet var searchField: UITextField!
    
    private let viewModel = GitSearchViewModel(network: Network())
    
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
        
        self.viewModel.error
            .observe(self.displayError)
        
        viewModel.activate()
        
        searchField.bnd_text
            .bindTo(viewModel.searchTerm)
    }
    
    private func displayError(error: String){
        let alertController = UIAlertController(title: "Computer says no!",
            message: error, preferredStyle: .Alert)
        self.presentViewController(alertController, animated: true, completion: nil)
        let actionOk = UIAlertAction(title: "OK", style: .Default,
            handler: { action in alertController.dismissViewControllerAnimated(true, completion: nil) })
        
        alertController.addAction(actionOk)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}