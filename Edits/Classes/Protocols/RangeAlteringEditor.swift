//
//  RangeAlteringEditor.swift
//  Edits
//
//  Created by William McGinty on 12/18/16.
//
//

import Foundation

public protocol RangeAlteringEditor: Editor {
    var isAdditive: Bool { get }
    
    var alteredElement: EditedType.Element { get }
    var alteredIndexOffset: EditedType.IndexDistance { get }
}

public struct AnyRangeAlteringEditor<T: Collection>: RangeAlteringEditor where T.Element: Equatable {
    
    //MARK: Properties
    private let editorDescription: String
    
    private let performer: (T) -> T
    private let tableEdit: (Int, UITableView) -> Void
    private let collectionEdit: (Int, UICollectionView) -> Void
    
    public let isAdditive: Bool
    public let alteredElement: T.Element
    public let alteredIndexOffset: T.IndexDistance
    
    //MARK: Initializers
    init<E: RangeAlteringEditor>(editor: E) where E.EditedType == T {
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
