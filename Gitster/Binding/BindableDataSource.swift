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
    typealias mapper = AnyObject -> T

    let fetchController: FetchedResultsControllerType
    private let map: mapper
    
    init(fetchController: FetchedResultsControllerType, map: mapper){
        self.fetchController = fetchController
        self.map = map
    }
    
    subscript(section: Int, row: Int) -> T{
        let object = fetchController.objectAtIndexPath(NSIndexPath(forRow: row, inSection: section));
        let mapped = map(object)
        
        return mapped
    }
    
    var data: [T]? {
        return fetchController.fetchedObjects?.map(map)
    }
}

extension UITableView {
    private struct AssociatedKeys {
        static var BondFetchedResultsDataSourceKey = "bnd_FetchedResults_BondDataSourceKey"
    }
}

extension BindableDataSource {
    
    func bindTo(tableView: UITableView, proxyDataSource: BNDFetchTableViewProxyDataSource? = nil, createCell: (NSIndexPath, BindableDataSource, UITableView) -> UITableViewCell) -> DisposableType {
        
        let dataSource = TableViewFetchDataSource(bindableDataSource: self, tableView: tableView, proxyDataSource: proxyDataSource, createCell: createCell)
        objc_setAssociatedObject(tableView, &UITableView.AssociatedKeys.BondFetchedResultsDataSourceKey, dataSource, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        return BlockDisposable { [weak tableView] in
            if let tableView = tableView {
                objc_setAssociatedObject(tableView, &UITableView.AssociatedKeys.BondFetchedResultsDataSourceKey, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}