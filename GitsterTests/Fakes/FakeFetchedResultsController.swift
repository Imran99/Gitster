//
//  FakeFetchedResultsController.swift
//  Gitster
//
//  Created by Imran on 26/02/2016.
//  Copyright © 2016 AppBrains. All rights reserved.
//

import CoreData

class FakeFetchedResultsController : FetchedResultsControllerType{
    private(set) var items = [[AnyObject]]()
    var sections: [NSFetchedResultsSectionInfo]? {
        return fakeSections
    }
    private var fakeSections = [FakeNSFetchedResultsSectionInfo]()
    weak var delegate: NSFetchedResultsControllerDelegate?
    var fetchedObjects: [AnyObject]? { fatalError("not implemented") }
    
    func objectAtIndexPath(indexPath: NSIndexPath) -> AnyObject{
        return items[indexPath.section][indexPath.row]
    }
    
    func append(section: Int, item: AnyObject){
        items[section].append(item)
        fakeSections[section].objects!.append(item)
        
        let indexPath = NSIndexPath(forItem: items[section].count-1, inSection: section)
        delegate?.controller?(NSFetchedResultsController(), didChangeObject: item, atIndexPath: indexPath, forChangeType: .Insert, newIndexPath: nil)
    }
    
    func update(section: Int, row: Int, item: AnyObject){
        items[section][row] = item
        
        let indexPath = NSIndexPath(forItem: row, inSection: section)
        delegate?.controller?(NSFetchedResultsController(), didChangeObject: item, atIndexPath: indexPath, forChangeType: .Update, newIndexPath: nil)
    }
    
    func delete(section: Int, row: Int){
        let item = items[section].removeAtIndex(row)
        fakeSections[section].objects?.removeAtIndex(row)
        
        let indexPath = NSIndexPath(forItem: row, inSection: section)
        delegate?.controller?(NSFetchedResultsController(), didChangeObject: item, atIndexPath: indexPath, forChangeType: .Delete, newIndexPath: nil)
    }
    
    func appendSection(){
        items.append([AnyObject]())
        let fakeSection = FakeNSFetchedResultsSectionInfo()
        fakeSection.objects = [AnyObject]()
        fakeSections.append(fakeSection)
        
        delegate?.controller?(NSFetchedResultsController(), didChangeSection: fakeSection, atIndex: fakeSections.count-1, forChangeType: .Insert)
    }
    
    func updateSection(section: Int){
        let fakeSection = fakeSections[section]
        
        delegate?.controller?(NSFetchedResultsController(), didChangeSection: fakeSection, atIndex: section, forChangeType: .Update)
    }
    
    func deleteSection(section: Int){
        let fakeSection = fakeSections.removeAtIndex(section)
        
        delegate?.controller?(NSFetchedResultsController(), didChangeSection: fakeSection, atIndex: section, forChangeType: .Delete)
    }
}