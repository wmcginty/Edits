//
//  Deletion.swift
//  Pods
//
//  Created by William McGinty on 11/9/16.
//
//

import Foundation

public struct Deletion<T: RangeReplaceableCollection>: RangeAlteringEditor {
    
    //MARK: Properties
    let deleted: T.Iterator.Element
    let index: T.Index
    
    //MARK: Editor
    public func perform(with input: T) -> T {
        var output = input
        output.remove(at: index)
        
        return output
    }
    
    public var description: String {
        return "Delete \(deleted) from index \(index)"
    }
    
    //MARK: RangeAlteringEditor
    public var isAdditive: Bool {
        return false
    }
    
    public var alteredElement: T.Iterator.Element {
        return deleted
    }
    
    public var alteredIndex: T.Index {
        return index
    }
}
