//
//  Substitution.swift
//  Edits
//
//  Created by William McGinty on 11/9/16.
//
//

import Foundation

public struct Substitution<T: RangeReplaceableCollection>: Editor, Equatable where T.IndexDistance == Int, T.Element: Equatable {
    
    //MARK: Properties
    public let source: T
    public let from: T.Iterator.Element
    public let to: T.Iterator.Element
    public let index: T.Index
    
    public init(source: T, from: T.Iterator.Element, to: T.Iterator.Element, atIndex index: T.Index) {
        self.source = source
        self.from = from
        self.to = to
        self.index = index
    }
    
    //MARK: CustomStringConvertible
    public var description: String {
        return "Substitute \(to) for the \(from) at index \(source.distance(from: source.startIndex, to: index))"
    }
    
    //MARK: Editor
    public func perform(with input: T) -> T {
        var output = input
        output.remove(at: index)
        output.insert(to, at: index)
        
        return output
    }
    
    public func edit(forSection section: Int, in tableView: UITableView) {
        let path = IndexPath(row: source.distance(from: source.startIndex, to: index), section: section)
        tableView.reloadRows(at: [path], with: .automatic)
    }
    
    public func edit(forSection section: Int, in collectionView: UICollectionView) {
        let path = IndexPath(item: source.distance(from: source.startIndex, to: index), section: section)
        collectionView.reloadItems(at: [path])
    }
    
    //MARK: Equatable
    public static func ==(lhs: Substitution<T>, rhs: Substitution<T>) -> Bool {
        return lhs.from == rhs.from && lhs.to == rhs.to && lhs.index == rhs.index
    }
}
