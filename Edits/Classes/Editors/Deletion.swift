//
//  Deletion.swift
//  Edits
//
//  Created by William McGinty on 11/9/16.
//
//

import Foundation

public struct Deletion<T: RangeReplaceableCollection>: RangeAlteringEditor, Equatable where T.IndexDistance == Int, T.Element: Equatable {
    
    //MARK: Properties
    public let deleted: T.Element
    public let offset: T.IndexDistance
    
    public init(source: T, deleted: T.Element, atIndex index: T.Index) {
        let offset = source.distance(from: source.startIndex, to: index)
        self.init(deleted: deleted, atIndexOffset: offset)
    }
    
    public init(deleted: T.Element, atIndexOffset offset: T.IndexDistance) {
        self.deleted = deleted
        self.offset = offset
    }
    
    //MARK: CustomStringConvertible
    public var description: String {
        return "Delete \(deleted) from position \(offset)"
    }
    
    //MARK: Editor
    public func perform(with input: T) -> T {
        var output = input
        output.remove(at: input.index(input.startIndex, offsetBy: offset))
        
        return output
    }
    
    func affectedIndexPath(forSection section: Int) -> IndexPath {
        return IndexPath(item: offset, section: section)
    }
    
    public func edit(forSection section: Int, in tableView: UITableView) {
        tableView.deleteRows(at: [affectedIndexPath(forSection: section)], with: .automatic)
    }
    
    public func edit(forSection section: Int, in collectionView: UICollectionView) {
        collectionView.deleteItems(at: [affectedIndexPath(forSection: section)])
    }
    
    //MARK: RangeAlteringEditor
    public var isAdditive: Bool { return false }
    public var alteredElement: T.Element { return deleted }
    public var alteredIndexOffset: T.IndexDistance { return offset }
    
    //MARK: Equatable
    public static func ==(lhs: Deletion<T>, rhs: Deletion<T>) -> Bool {
        return lhs.alteredElement == rhs.alteredElement && lhs.alteredIndexOffset == rhs.alteredIndexOffset
    }
}
