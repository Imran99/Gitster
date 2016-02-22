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
    @IBOutlet var loadingSpinner: UIActivityIndicatorView!
    
    private let viewModel = GitSearchViewModel(network: Network())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        bind()
    }
    
    private func setupView(){
        //don animations and view type stuff here
    }
    
    private func bind(){
        viewModel.gists
            .lift()
            .bindTo(tableView) { indexPath, dataSource, tableView in
                let cell = tableView.dequeueReusableCellWithIdentifier(String(UITableViewCell))!
                let summary = dataSource[indexPath.section][indexPath.row]
                cell.textLabel!.text = summary.name
                return cell
        }

        viewModel.error
            .observe(self.displayError)
        
        viewModel.searchTerm
            .bidirectionalBindTo(searchField.bnd_text)
        
        viewModel.searchInProgress
            .map{!$0}
            .bindTo(loadingSpinner.bnd_hidden)

        viewModel.activate()
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(String(GitDetailsViewController), sender: self)
    }

    //MARK: Other UIKit
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let selectedIndex = tableView.indexPathForSelectedRow
        let vc = segue.destinationViewController as! GitDetailsViewController
        let summary = viewModel.gists.lift()[selectedIndex!.section][selectedIndex!.row]
        vc.repositoryUrl = summary.url
    }
}