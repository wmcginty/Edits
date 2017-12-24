//
//  Insertion.swift
//  Edits
//
//  Created by William McGinty on 11/9/16.
//
//

import Foundation

struct Insertion<T: RangeReplaceableCollection>: RangeAlteringEditor, Equatable where T.IndexDistance == Int, T.Element: Equatable {
    
    //MARK: Properties
    let inserted: T.Element
    let offset: T.IndexDistance
    
    init(source: T, inserted: T.Element, atIndex index: T.Index) {
        let offset = source.distance(from: source.startIndex, to: index)
        self.init(inserted: inserted, atIndexOffset: offset)
    }
    
    init(inserted: T.Element, atIndexOffset offset: T.IndexDistance) {
        self.inserted = inserted
        self.offset = offset
    }
    
    //MARK: CustomStringConvertible
    var description: String {
        return "Insert \(inserted) at index \(offset)"
    }
    
    //MARK: Editor
    func perform(with input: T) -> T {
        var output = input
        output.insert(inserted, at: input.index(input.startIndex, offsetBy: offset))
        
        return output
    }
    
    func affectedIndexPath(forSection section: Int) -> IndexPath {
        return IndexPath(item: offset, section: section)
    }
    
    func edit(forSection section: Int, in tableView: UITableView) {
        tableView.insertRows(at: [affectedIndexPath(forSection: section)], with: .automatic)
    }
    
    func edit(forSection section: Int, in collectionView: UICollectionView) {
        collectionView.insertItems(at: [affectedIndexPath(forSection: section)])
    }
    
    //MARK: RangeAlteringEditor
    var isAdditive: Bool { return true }
    var alteredElement: T.Element { return inserted }
    var alteredIndexOffset: T.IndexDistance { return offset }
    
    //MARK: Equatable
    static func ==(lhs: Insertion<T>, rhs: Insertion<T>) -> Bool {
        return lhs.inserted == rhs.inserted && lhs.offset == rhs.offset
    }
}
