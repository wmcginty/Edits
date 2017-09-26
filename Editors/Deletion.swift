//
//  Deletion.swift
//  Edits
//
//  Created by William McGinty on 11/9/16.
//
//

import Foundation

public struct Deletion<T: RangeReplaceableCollection>: RangeAlteringEditor {
    
    //MARK: Properties
    public let source: T
    public let deleted: T.Iterator.Element
    public let index: T.Index
    
    public init(source: T, deleted: T.Iterator.Element, atIndex index: T.Index) {
        self.source = source
        self.deleted = deleted
        self.index = index
    }
    
    //MARK: Editor
    public func perform(with input: T) -> T {
        var output = input
        output.remove(at: index)
        
        return output
    }
    
    public var description: String {
        return "Delete \(deleted) from position \(source.distance(from: source.startIndex, to: index))"
    }
    
    //MARK: RangeAlteringEditor
    public var isAdditive: Bool { return false }
    public var alteredElement: T.Iterator.Element { return deleted }
    public var alteredIndex: T.Index { return index }
}
