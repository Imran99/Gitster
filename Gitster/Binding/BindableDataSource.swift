//
//  ObservableDataSource.swift
//  Gitster
//
//  Created by Imran on 23/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import UIKit
import Bond

class BindableDataSource<T> {
    typealias map = AnyObject -> T

    private let fetchController: FetchedResultsControllerType
    private let mapper: map
    
    init(fetchController: FetchedResultsControllerType, mapper: map){
        self.fetchController = fetchController
        self.mapper = mapper
    }
    
    subscript(section: Int, row: Int) -> T{
        let object = fetchController.objectAtIndexPath(NSIndexPath(forRow: row, inSection: section));
        let mapped = mapper(object)
        
        return mapped
    }
}

extension UITableView {
    private struct AssociatedKeys {
        static var BondFetchedResultsDataSourceKey = "bnd_FetchedResults_BondDataSourceKey"
    }
}

extension BindableDataSource {
    
    func bindTo(tableView: UITableView, proxyDataSource: BNDTableViewProxyDataSource? = nil, createCell: (NSIndexPath, FetchedResultsControllerType, UITableView) -> UITableViewCell) -> DisposableType {
        
        let dataSource = TableViewFetchDataSource(fetchController: self.fetchController, tableView: tableView, proxyDataSource: proxyDataSource, createCell: createCell)
        objc_setAssociatedObject(tableView, &UITableView.AssociatedKeys.BondFetchedResultsDataSourceKey, dataSource, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        return BlockDisposable { [weak tableView] in
            if let tableView = tableView {
                objc_setAssociatedObject(tableView, &UITableView.AssociatedKeys.BondFetchedResultsDataSourceKey, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}