//
//  Movement.swift
//  Pods
//
//  Created by William McGinty on 11/9/16.
//
//

import Foundation

public struct Movement<T: RangeReplaceableCollection>: Editor {
    
    //MARK: Properties
    let moving: T.Iterator.Element
    let from: T.Index
    let to: T.Index
    
    //MARK: Editor
    public func perform(with input: T) -> T {
        var output = input
        output.remove(at: from)
        output.insert(moving, at: to)
        
        return output
    }
    
    public var description: String {
        return "Move \(moving) from index \(from) to index \(to)"
    }
}
