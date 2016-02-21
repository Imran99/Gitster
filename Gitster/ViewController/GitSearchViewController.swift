//
//  ViewController.swift
//  Gister
//
//  Created by Imran on 16/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import UIKit
import Bond

class GitSearchViewController: UITableViewController, BNDTableViewProxyDataSource {

    @IBOutlet var searchField: UITextField!
    
    private let viewModel = GitSearchViewModel(network: Network())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        bind()
    }
    
    private func setupView(){
        self.tableView.contentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0)
    }
    
    private func bind(){
        viewModel.gists
            .lift()
            .bindTo(tableView, proxyDataSource: self) { indexPath, dataSource, tableView in
                let cell = tableView.dequeueReusableCellWithIdentifier(String(UITableViewCell))!
                let summary = dataSource[indexPath.section][indexPath.row]
                cell.textLabel!.text = summary.name
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
    
    //MARK: UITableView Methods
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(String(GitDetailsViewController), sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let selectedIndex = tableView.indexPathForSelectedRow
        let vc = segue.destinationViewController as! GitDetailsViewController
        let summary = viewModel.gists.lift()[selectedIndex!.section][selectedIndex!.row]
        vc.repositoryUrl = summary.url
    }
}