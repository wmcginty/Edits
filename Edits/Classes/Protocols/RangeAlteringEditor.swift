//
//  RangeAlteringEditor.swift
//  Edits
//
//  Created by William McGinty on 12/18/16.
//
//

import Foundation

/// An object capable of transforming a collection in a pre-defined way that will change the range of the collection.
public protocol RangeAlteringEditor: Editor {
    
    /// Denotes whether this transformation adds to or removes from the range of the collection.
    var isAdditive: Bool { get }
    
    /// The element that is altered by the editor.
    var alteredElement: EditedType.Element { get }
    
    /// The offset at which the index the transformation resides. For instance, if the transformation applies to the beginning of a collection, this value will be 0.
    var alteredIndexOffset: Int { get }
}

/// A type-erased wrapper struct around the Deletion, and Insertion edits. While their individual type can not be queried, their edit can be performed on any input.
public struct AnyRangeAlteringEditor<T: Collection>: RangeAlteringEditor where T.Element: Equatable {
    
    //MARK: Properties
    private let editorDescription: String
    
    private let performer: (T) -> T
    private let tableEdit: (Int, UITableView) -> Void
    private let collectionEdit: (Int, UICollectionView) -> Void
    
    public let isAdditive: Bool
    public let alteredElement: T.Element
    public let alteredIndexOffset: Int
    
    //MARK: Initializers
    public init<E: RangeAlteringEditor>(editor: E) where E.EditedType == T {
        editorDescription = editor.description
        
        performer = editor.perform
        tableEdit = editor.edit
        collectionEdit = editor.edit
        
        alteredElement = editor.alteredElement
        isAdditive = editor.isAdditive
        alteredIndexOffset = editor.alteredIndexOffset
    }
    
    //MARK: CustomStringConvertible
    public var description: String { return editorDescription }
    
    //MARK: Editor
    public func perform(with input: T) -> T {
        return performer(input)
    }
    
    public func edit(forSection section: Int, in tableView: UITableView) {
        tableEdit(section, tableView)
    }
    
    public func edit(forSection section: Int, in collectionView: UICollectionView) {
        collectionEdit(section, collectionView)
    }
}
