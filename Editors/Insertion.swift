//
//  Insertion.swift
//  Edits
//
//  Created by William McGinty on 11/9/16.
//
//

import Foundation

public struct Insertion<T: RangeReplaceableCollection>: RangeAlteringEditor {
    
    //MARK: Properties
    public let source: T
    public let inserted: T.Iterator.Element
    public let index: T.Index
    
    public init(source: T, inserted: T.Iterator.Element, atIndex index: T.Index) {
        self.source = source
        self.inserted = inserted
        self.index = index
    }
    
    //MARK: Editor
    public func perform(with input: T) -> T {
        var output = input
        output.insert(inserted, at: index)
        
        return output
    }
    
    public var description: String {
        return "Insert \(inserted) at index \(source.distance(from: source.startIndex, to: index))"
    }
    
    //MARK: RangeAlteringEditor
    public var isAdditive: Bool { return true }
    public var alteredElement: T.Iterator.Element { return inserted }
    public var alteredIndex: T.Index { return index }
}
