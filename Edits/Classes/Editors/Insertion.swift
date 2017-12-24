//
//  Insertion.swift
//  Edits
//
//  Created by William McGinty on 11/9/16.
//
//

import Foundation

public struct Insertion<T: RangeReplaceableCollection>: RangeAlteringEditor, Equatable where T.IndexDistance == Int, T.Element: Equatable {
    
    //MARK: Properties
    public let source: T
    public let inserted: T.Iterator.Element
    public let index: T.Index
    
    public init(source: T, inserted: T.Iterator.Element, atIndex index: T.Index) {
        self.source = source
        self.inserted = inserted
        self.index = index
    }
    
    //MARK: CustomStringConvertible
    public var description: String {
        return "Insert \(inserted) at index \(source.distance(from: source.startIndex, to: index))"
    }
    
    //MARK: Editor
    public func perform(with input: T) -> T {
        var output = input
        output.insert(inserted, at: index)
        
        return output
    }
    
    //MARK: Interface
    public func edit(forSection section: Int, in tableView: UITableView) {
        let path = IndexPath(row: source.distance(from: source.startIndex, to: index), section: section)
        tableView.insertRows(at: [path], with: .automatic)
    }
    
    public func edit(forSection section: Int, in collectionView: UICollectionView) {
        let path = IndexPath(item: source.distance(from: source.startIndex, to: index), section: section)
        collectionView.insertItems(at: [path])
    }
    
    //MARK: RangeAlteringEditor
    public var isAdditive: Bool { return true }
    public var alteredElement: T.Iterator.Element { return inserted }
    public var alteredIndex: T.Index { return index }
    
    //MARK: Equatable
    public static func ==(lhs: Insertion<T>, rhs: Insertion<T>) -> Bool {
        return lhs.inserted == rhs.inserted && lhs.index == rhs.index
    }
}
