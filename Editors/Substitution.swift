//
//  Substitution.swift
//  Edits
//
//  Created by William McGinty on 11/9/16.
//
//

import Foundation

public struct Substitution<T: RangeReplaceableCollection>: Editor {
    
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
    
    //MARK: Editor
    public func perform(with input: T) -> T {
        var output = input
        output.remove(at: index)
        output.insert(to, at: index)
        
        return output
    }
    
    public var description: String {
        return "Substitute \(to) for the \(from) at index \(source.distance(from: source.startIndex, to: index))"
    }
}
