//
//  Deletion.swift
//  Edits
//
//  Created by William McGinty on 11/9/16.
//
//

import Foundation

struct Deletion<T: RangeReplaceableCollection>: RangeAlteringEditor, Equatable where T.Element: Equatable {
    
    // MARK: Properties
    let deleted: T.Element
    let offset: Int
    
    init(source: T, deleted: T.Element, atIndex index: T.Index) {
        let offset = source.distance(from: source.startIndex, to: index)
        self.init(deleted: deleted, atIndexOffset: offset)
    }
    
    init(deleted: T.Element, atIndexOffset offset: Int) {
        self.deleted = deleted
        self.offset = offset
    }
    
    // MARK: CustomStringConvertible
    var description: String {
        return "Delete \(deleted) from position \(offset)"
    }
    
    // MARK: Editor
    func perform(with input: T) -> T {
        var output = input
        output.remove(at: input.index(input.startIndex, offsetBy: offset))
        
        return output
    }
    
    func affectedIndexPath(forSection section: Int) -> IndexPath {
        return IndexPath(item: offset, section: section)
    }
    
    func edit(forSection section: Int, in tableView: UITableView) {
        tableView.deleteRows(at: [affectedIndexPath(forSection: section)], with: .automatic)
    }
    
    func edit(forSection section: Int, in collectionView: UICollectionView) {
        collectionView.deleteItems(at: [affectedIndexPath(forSection: section)])
    }
    
    // MARK: RangeAlteringEditor
    var isAdditive: Bool { return false }
    var alteredElement: T.Element { return deleted }
    var alteredIndexOffset: Int { return offset }
    
    // MARK: Equatable
    static func == (lhs: Deletion<T>, rhs: Deletion<T>) -> Bool {
        return lhs.alteredElement == rhs.alteredElement && lhs.alteredIndexOffset == rhs.alteredIndexOffset
    }
}
