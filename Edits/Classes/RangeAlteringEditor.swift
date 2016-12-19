//
//  RangeAlteringEditor.swift
//  Pods
//
//  Created by William McGinty on 12/18/16.
//
//

import Foundation

public protocol RangeAlteringEditor: Editor {
    
    var isAdditive: Bool { get }
    
    var alteredElement: EditedType.Iterator.Element { get }
    var alteredIndex: EditedType.Index { get }
}

public struct AnyRangeAlteringEditor<T: RangeReplaceableCollection>: RangeAlteringEditor {
    
    //MARK: Properties
    private let performer: (T) -> T
    private let desc: String
    
    public let isAdditive: Bool
    public let alteredElement: T.Iterator.Element
    public let alteredIndex: T.Index
    
    //MARK: Initializers
    init<E: RangeAlteringEditor>(editor: E) where E.EditedType == T {
        performer = editor.perform
        desc = editor.description
        
        alteredElement = editor.alteredElement
        isAdditive = editor.isAdditive
        alteredIndex = editor.alteredIndex
    }
    
    //MARK: Editor
    public func perform(with input: T) -> T {
        return performer(input)
    }
    
    public var description: String {
        return desc
    }
}
