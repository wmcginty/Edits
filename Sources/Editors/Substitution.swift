//
//  Substitution.swift
//  Edits
//
//  Created by William McGinty on 11/9/16.
//
//

import Foundation

struct Substitution<T: RangeReplaceableCollection>: Editor, Equatable where T.Element: Equatable {
    
    // MARK: Properties
    let from: T.Element
    let to: T.Element
    let offset: Int
    
    init(source: T, from: T.Element, to: T.Element, atIndex index: T.Index) {
        let offset = source.distance(from: source.startIndex, to: index)
        self.init(from: from, to: to, atIndexOffset: offset)
    }
    
    init(from: T.Element, to: T.Element, atIndexOffset offset: Int) {
        self.from = from
        self.to = to
        self.offset = offset
    }
    
    // MARK: CustomStringConvertible
    var description: String {
        return "Substitute \(to) for the \(from) at index \(offset)"
    }
    
    // MARK: Editor
    func perform(with input: T) -> T {
        var output = input
        output.remove(at: input.index(input.startIndex, offsetBy: offset))
        output.insert(to, at: input.index(input.startIndex, offsetBy: offset))
        
        return output
    }
    
    func affectedIndexPath(forSection section: Int) -> IndexPath {
        return IndexPath(item: offset, section: section)
    }
    
    func edit(forSection section: Int, in tableView: UITableView) {
        tableView.reloadRows(at: [affectedIndexPath(forSection: section)], with: .automatic)
    }
    
    func edit(forSection section: Int, in collectionView: UICollectionView) {
        collectionView.reloadItems(at: [affectedIndexPath(forSection: section)])
    }
    
    // MARK: Equatable
    static func == (lhs: Substitution<T>, rhs: Substitution<T>) -> Bool {
        return lhs.from == rhs.from && lhs.to == rhs.to && lhs.offset == rhs.offset
    }
}
