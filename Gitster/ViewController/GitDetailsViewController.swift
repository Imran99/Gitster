//
//  GitDetailsViewController.swift
//  Gitster
//
//  Created by Imran on 21/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import UIKit

class GitDetailsViewController: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var detailsLabel: UILabel!
    @IBOutlet var userImage: UIImageView!
    
    var repositoryUrl: String?
    
    private var viewModel: GitDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = GitDetailsViewModel(network: Network(), url:repositoryUrl!)
        
        viewModel.name
            .bindTo(nameLabel.bnd_text)
        
        viewModel.description
            .bindTo(detailsLabel.bnd_text)
        
        viewModel.avatarUrl
            .observe{ url in
                let backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)
                dispatch_async(backgroundQueue) {
                    if let imageData = NSData(contentsOfURL: NSURL(string: url)!) {
                        dispatch_async(dispatch_get_main_queue()) {
                            self.userImage.image = UIImage(data: imageData)
                        }
                    }
                }
        }
        
        viewModel.activate()
    }
}