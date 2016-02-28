import UIKit
import CoreData
import Bond

class TableViewFetchDataSource: NSObject, UITableViewDataSource, NSFetchedResultsControllerDelegate{
    
    private let fetchController: FetchedResultsControllerType
    private weak var tableView: UITableView!
    private let createCell: (NSIndexPath, FetchedResultsControllerType, UITableView) -> UITableViewCell
    private weak var proxyDataSource: BNDTableViewProxyDataSource?
    private let sectionObservingDisposeBag = DisposeBag()
    
    init(fetchController: FetchedResultsControllerType, tableView: UITableView, proxyDataSource: BNDTableViewProxyDataSource?, createCell: (NSIndexPath, FetchedResultsControllerType, UITableView) -> UITableViewCell) {
        self.fetchController = fetchController
        self.createCell = createCell
        self.tableView = tableView
        
        self.tableView.reloadData()
    }
    
    @objc func controllerWillChangeContent(controller: NSFetchedResultsController) {
    }
    
    @objc func controllerDidChangeContent(controller: NSFetchedResultsController) {
    }
    
    @objc func controller(controller: NSFetchedResultsController, didChangeSection: NSFetchedResultsSectionInfo, atIndex: Int, forChangeType: NSFetchedResultsChangeType){
    }
    
    @objc func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
    }
    
    /// MARK - UITableViewDataSource
    
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        return UITableViewCell()
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