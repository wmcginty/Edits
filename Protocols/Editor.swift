//
//  Editor.swift
//  Edits
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
    
    //MARK: Properties
    private let performer: (T) -> T
    private let desc: String
    
    //MARK: Initializers
    init<E: Editor>(editor: E) where E.EditedType == T {
        performer = editor.perform
        desc = editor.description
    }
    
    //MARK: Editor
    public func perform(with input: T) -> T {
        return performer(input)
    }
    
    public var description: String {
        return desc
    }
}

