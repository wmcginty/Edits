//
//  Movement.swift
//  Edits
//
//  Created by William McGinty on 11/9/16.
//
//

import Foundation

struct Movement<T: RangeReplaceableCollection>: Editor, Equatable where T.Element: Equatable {
    
    //MARK: Properties
    let moving: T.Element
    let from: Int
    let to: Int
    
    init(source: T, move: T.Element, fromIndex from: T.Index, toIndex to: T.Index) {
        let fromOffset = source.distance(from: source.startIndex, to: from)
        let toOffset = source.distance(from: source.startIndex, to: to)
        self.init(move: move, fromIndexOffset: fromOffset, toIndexOffset: toOffset)
    }
    
    init(move: T.Element, fromIndexOffset from: Int, toIndexOffset to: Int) {
        self.moving = move
        self.from = from
        self.to = to
    }
    
    //MARK: CustomStringConvertible
    var description: String {
        return "Move \(moving) from index \(from) to index \(to)"
    }
    
    //MARK: Editor
    func perform(with input: T) -> T {
        var output = input
        output.remove(at: input.index(input.startIndex, offsetBy: from))
        output.insert(moving, at: input.index(input.startIndex, offsetBy: to))
        
        return output
    }
    
    func sourceIndexPath(forSection section: Int) -> IndexPath {
        return IndexPath(item: from, section: section)
    }
    
    func destinationIndexPath(forSection section: Int) -> IndexPath {
        return IndexPath(item: to, section: section)
    }
    
    func edit(forSection section: Int, in tableView: UITableView) {
        tableView.moveRow(at: sourceIndexPath(forSection: section), to: destinationIndexPath(forSection: section))
    }
    
    func edit(forSection section: Int, in collectionView: UICollectionView) {
        collectionView.moveItem(at: sourceIndexPath(forSection: section), to: destinationIndexPath(forSection: section))
    }
    
    //MARK: Equatable
    static func ==(lhs: Movement<T>, rhs: Movement<T>) -> Bool {
        return lhs.moving == rhs.moving && lhs.from == rhs.from && lhs.to == rhs.to
    }
}
