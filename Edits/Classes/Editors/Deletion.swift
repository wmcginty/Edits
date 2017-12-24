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
    public let source: T
    public let deleted: T.Iterator.Element
    public let index: T.Index
    
    public init(source: T, deleted: T.Iterator.Element, atIndex index: T.Index) {
        self.source = source
        self.deleted = deleted
        self.index = index
    }
    
    //MARK: CustomStringConvertible
    public var description: String {
        return "Delete \(deleted) from position \(source.distance(from: source.startIndex, to: index))"
    }
    
    //MARK: Editor
    public func perform(with input: T) -> T {
        var output = input
        output.remove(at: index)
        
        return output
    }
    
    public func edit(forSection section: Int, in tableView: UITableView) {
        let path = IndexPath(row: source.distance(from: source.startIndex, to: index), section: section)
        tableView.deleteRows(at: [path], with: .automatic)
    }
    
    public func edit(forSection section: Int, in collectionView: UICollectionView) {
        let path = IndexPath(item: source.distance(from: source.startIndex, to: index), section: section)
        collectionView.deleteItems(at: [path])
    }
    
    //MARK: RangeAlteringEditor
    public var isAdditive: Bool { return false }
    public var alteredElement: T.Iterator.Element { return deleted }
    public var alteredIndex: T.Index { return index }
    
    //MARK: Equatable
    public static func ==(lhs: Deletion<T>, rhs: Deletion<T>) -> Bool {
        return lhs.alteredElement == rhs.alteredElement && lhs.alteredIndex == rhs.alteredIndex
    }
}
