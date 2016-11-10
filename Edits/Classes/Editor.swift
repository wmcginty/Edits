//
//  Editor.swift
//  Pods
//
//  Created by William McGinty on 11/9/16.
//
//

import Foundation

public protocol Editor: CustomStringConvertible {
    associatedtype EditedType: RangeReplaceableCollection
    
    func perform(with input: EditedType) -> EditedType
}

public struct AnyEditor<T: RangeReplaceableCollection>: Editor {
    
    private let performer: (T) -> T
    private let desc: String
    
    init<U: Editor>(editor: U) where U.EditedType == T {
        performer = editor.perform
        desc = editor.description
    }
    
    public func perform(with input: T) -> T {
        return performer(input)
    }
    
    public var description: String {
        return desc
    }
}


