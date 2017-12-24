//
//  Movement.swift
//  Edits
//
//  Created by William McGinty on 11/9/16.
//
//

import Foundation

public struct Movement<T: RangeReplaceableCollection>: Editor, Equatable where T.IndexDistance == Int, T.Element: Equatable {
    
    //MARK: Properties
    public let moving: T.Element
    public let from: T.IndexDistance
    public let to: T.IndexDistance
    
    public init(source: T, move: T.Element, fromIndex from: T.Index, toIndex to: T.Index) {
        let fromOffset = source.distance(from: source.startIndex, to: from)
        let toOffset = source.distance(from: source.startIndex, to: to)
        self.init(move: move, fromIndexOffset: fromOffset, toIndexOffset: toOffset)
    }
    
    public init(move: T.Element, fromIndexOffset from: T.IndexDistance, toIndexOffset to: T.IndexDistance) {
        self.moving = move
        self.from = from
        self.to = to
    }
    
    //MARK: CustomStringConvertible
    public var description: String {
        return "Move \(moving) from index \(from) to index \(to)"
    }
    
    //MARK: Editor
    public func perform(with input: T) -> T {
        var output = input
        output.remove(at: input.index(input.startIndex, offsetBy: from))
        output.insert(moving, at: input.index(input.startIndex, offsetBy: to))
        
        return output
    }
    
    public func edit(forSection section: Int, in tableView: UITableView) {
        let sourcePath = IndexPath(row: from, section: section)
        let destinationPath = IndexPath(row: to, section: section)
        tableView.moveRow(at: sourcePath, to: destinationPath)
    }
    
    public func edit(forSection section: Int, in collectionView: UICollectionView) {
        let sourcePath = IndexPath(item: from, section: section)
        let destinationPath = IndexPath(item: to, section: section)
        collectionView.moveItem(at: sourcePath, to: destinationPath)
    }
    
    //MARK: Equatable
    public static func ==(lhs: Movement<T>, rhs: Movement<T>) -> Bool {
        return lhs.moving == rhs.moving && lhs.from == rhs.from && lhs.to == rhs.to
    }
}
