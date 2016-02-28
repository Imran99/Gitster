import UIKit
import CoreData
import Bond

class TableViewFetchDataSource<T>: NSObject, UITableViewDataSource, NSFetchedResultsControllerDelegate{
    
    private let bindableDataSource: BindableDataSource<T>
    private let fetchController: FetchedResultsControllerType
    private weak var tableView: UITableView!
    private let createCell: (NSIndexPath, BindableDataSource<T>, UITableView) -> UITableViewCell
    private weak var proxyDataSource: BNDTableViewProxyDataSource?
    private let sectionObservingDisposeBag = DisposeBag()
    
    init(bindableDataSource: BindableDataSource<T>, tableView: UITableView, proxyDataSource: BNDTableViewProxyDataSource?, createCell: (NSIndexPath, BindableDataSource<T>, UITableView) -> UITableViewCell) {
        self.bindableDataSource = bindableDataSource
        self.fetchController = bindableDataSource.fetchController
        self.createCell = createCell
        self.tableView = tableView
        
        super.init()
        
        self.tableView.dataSource = self
        fetchController.delegate = self
        self.tableView.reloadData()
    }
    
    @objc func controllerWillChangeContent(controller: NSFetchedResultsController) {
    }
    
    @objc func controllerDidChangeContent(controller: NSFetchedResultsController) {
    }
    
    //todo user rowanimations
    @objc func controller(controller: NSFetchedResultsController, didChangeSection: NSFetchedResultsSectionInfo, atIndex: Int, forChangeType: NSFetchedResultsChangeType){

        let index = NSIndexSet(index: atIndex);
        switch forChangeType{
        case .Insert:
            tableView.insertSections(index, withRowAnimation: .Automatic)
        case .Update:
            tableView.reloadSections(index, withRowAnimation: .Automatic)
        case .Delete:
            tableView.deleteSections(index, withRowAnimation: .Automatic)
        default:
            fatalError("todo")
        }
    }
    
    //todo user rowanimations
    @objc func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        let indexPaths = [indexPath!]
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        case .Update:
            tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        case .Delete:
            tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        default:
            fatalError("not supported")
        }
    }
    
    /// MARK - UITableViewDataSource
    
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchController.sections?.count ?? 0
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchController.sections![section].numberOfObjects
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        return createCell(indexPath, bindableDataSource, tableView)
    }
    
    @objc func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    @objc func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return nil
    }
    
    @objc func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    @objc func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    @objc func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return nil
    }
    
    @objc func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return 0
    }
    
    @objc func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    @objc func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
    }
}