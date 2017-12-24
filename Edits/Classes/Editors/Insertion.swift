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
    public let inserted: T.Element
    public let offset: T.IndexDistance
    
    public init(source: T, inserted: T.Element, atIndex index: T.Index) {
        let offset = source.distance(from: source.startIndex, to: index)
        self.init(inserted: inserted, atIndexOffset: offset)
    }
    
    public init(inserted: T.Element, atIndexOffset offset: T.IndexDistance) {
        self.inserted = inserted
        self.offset = offset
    }
    
    //MARK: CustomStringConvertible
    public var description: String {
        return "Insert \(inserted) at index \(offset)"
    }
    
    //MARK: Editor
    public func perform(with input: T) -> T {
        var output = input
        output.insert(inserted, at: input.index(input.startIndex, offsetBy: offset))
        
        return output
    }
    
    func affectedIndexPath(forSection section: Int) -> IndexPath {
        return IndexPath(item: offset, section: section)
    }
    
    public func edit(forSection section: Int, in tableView: UITableView) {
        tableView.insertRows(at: [affectedIndexPath(forSection: section)], with: .automatic)
    }
    
    public func edit(forSection section: Int, in collectionView: UICollectionView) {
        collectionView.insertItems(at: [affectedIndexPath(forSection: section)])
    }
    
    //MARK: RangeAlteringEditor
    public var isAdditive: Bool { return true }
    public var alteredElement: T.Element { return inserted }
    public var alteredIndexOffset: T.IndexDistance { return offset }
    
    //MARK: Equatable
    public static func ==(lhs: Insertion<T>, rhs: Insertion<T>) -> Bool {
        return lhs.inserted == rhs.inserted && lhs.offset == rhs.offset
    }
}
