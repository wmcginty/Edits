//
//  Deletion.swift
//  Pods
//
//  Created by William McGinty on 11/9/16.
//
//

import Foundation

public struct Deletion<T: RangeReplaceableCollection>: Editor {
    
    let deleted: T.Iterator.Element
    let index: T.Index
    
    public func perform(with input: T) -> T {
        var output = input
        output.remove(at: index)
        
        return output
    }
    
    public var description: String {
        return "Delete \(deleted) from index \(index)"
    }
}
