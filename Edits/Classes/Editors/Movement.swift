//
//  Movement.swift
//  Edits
//
//  Created by William McGinty on 11/9/16.
//
//

import Foundation

public struct Movement<T: RangeReplaceableCollection>: Editor  where T.IndexDistance == Int {
    
    //MARK: Properties
    public let source: T
    public let moving: T.Iterator.Element
    public let from: T.Index
    public let to: T.Index
    
    public init(source: T, move: T.Iterator.Element, fromIndex from: T.Index, toIndex to: T.Index) {
        self.source = source
        self.moving = move
        self.from = from
        self.to = to
    }
    
    //MARK: Editor
    public func perform(with input: T) -> T {
        var output = input
        output.remove(at: from)
        output.insert(moving, at: to)
        
        return output
    }
    
    public var description: String {
        return "Move \(moving) from index \(source.distance(from: source.startIndex, to: from)) to index \(source.distance(from: source.startIndex, to: to))"
    }
    
    public func edit(forSection section: Int, in tableView: UITableView) {
        let sourcePath = IndexPath(row: source.distance(from: source.startIndex, to: from), section: section)
        let destinationPath = IndexPath(row: source.distance(from: source.startIndex, to: to), section: section)
        tableView.moveRow(at: sourcePath, to: destinationPath)
    }
    
    public func edit(forSection section: Int, in collectionView: UICollectionView) {
        let sourcePath = IndexPath(item: source.distance(from: source.startIndex, to: from), section: section)
        let destinationPath = IndexPath(item: source.distance(from: source.startIndex, to: to), section: section)
        collectionView.moveItem(at: sourcePath, to: destinationPath)
    }
}
