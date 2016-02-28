import UIKit
import Bond
import XCTest

enum TableOperation {
    case InsertRows([NSIndexPath])
    case DeleteRows([NSIndexPath])
    case ReloadRows([NSIndexPath])
    case InsertSections(NSIndexSet)
    case DeleteSections(NSIndexSet)
    case ReloadSections(NSIndexSet)
    case ReloadData
}

func ==(op0: TableOperation, op1: TableOperation) -> Bool {
    switch (op0, op1) {
    case let (.InsertRows(paths0), .InsertRows(paths1)):
        return paths0 == paths1
    case let (.DeleteRows(paths0), .DeleteRows(paths1)):
        return paths0 == paths1
    case let (.ReloadRows(paths0), .ReloadRows(paths1)):
        return paths0 == paths1
    case let (.InsertSections(i0), .InsertSections(i1)):
        return i0.isEqualToIndexSet(i1)
    case let (.DeleteSections(i0), .DeleteSections(i1)):
        return i0.isEqualToIndexSet(i1)
    case let (.ReloadSections(i0), .ReloadSections(i1)):
        return i0.isEqualToIndexSet(i1)
    case (.ReloadData, .ReloadData):
        return true
    default:
        return false
    }
}

extension TableOperation: Equatable, CustomStringConvertible {
    var description: String {
        switch self {
        case let .InsertRows(indexPaths):
            return "InsertRows(\(indexPaths)"
        case let .DeleteRows(indexPaths):
            return "DeleteRows(\(indexPaths)"
        case let .ReloadRows(indexPaths):
            return "ReloadRows(\(indexPaths)"
        case let .InsertSections(indices):
            return "InsertSections(\(indices)"
        case let .DeleteSections(indices):
            return "DeleteSections(\(indices)"
        case let .ReloadSections(indices):
            return "ReloadSections(\(indices)"
        case .ReloadData:
            return "ReloadData"
        }
    }
}

class FakeTableView: UITableView {
    var operations = [TableOperation]()
    override func insertRowsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        operations.append(.InsertRows(indexPaths))
        super.insertRowsAtIndexPaths(indexPaths, withRowAnimation: animation)
    }
    
    override func deleteRowsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        operations.append(.DeleteRows(indexPaths))
        super.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: animation)
    }
    
    override func reloadRowsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        operations.append(.ReloadRows(indexPaths))
        super.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: animation)
    }
    
    override func insertSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        operations.append(.InsertSections(sections))
        super.insertSections(sections, withRowAnimation: animation)
    }
    
    override func deleteSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        operations.append(.DeleteSections(sections))
        super.deleteSections(sections, withRowAnimation: animation)
    }
    
    override func reloadSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        operations.append(.ReloadSections(sections))
        super.reloadSections(sections, withRowAnimation: animation)
    }
    
    override func reloadData() {
        operations.append(.ReloadData)
        super.reloadData()
    }
}