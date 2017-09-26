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
    let inserted: T.Iterator.Element
    let index: T.Index
    
    //MARK: Editor
    public func perform(with input: T) -> T {
        var output = input
        output.insert(inserted, at: index)
        
        return output
    }
    
    public var description: String {
        return "Insert \(inserted) at index \(index)"
    }
    
    //MARK: RangeAlteringEditor
    public var isAdditive: Bool {
        return true
    }
    
    public var alteredElement: T.Iterator.Element {
        return inserted
    }
    
    public var alteredIndex: T.Index {
        return index
    }
}
