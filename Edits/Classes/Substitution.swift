//
//  Substitution.swift
//  Pods
//
//  Created by William McGinty on 11/9/16.
//
//

import Foundation

public struct Substitution<T: RangeReplaceableCollection>: Editor {
    
    let from: T.Iterator.Element
    let to: T.Iterator.Element
    let index: T.Index
    
    public func perform(with input: T) -> T {
        var output = input
        output.remove(at: index)
        output.insert(to, at: index)
        
        return output
    }
    
    public var description: String {
        return "Substitute \(from) with \(to) at index \(index)"
    }
}
