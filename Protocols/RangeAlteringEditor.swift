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
    
    var alteredElement: EditedType.Iterator.Element { get }
    var alteredIndex: EditedType.Index { get }
}

public struct AnyRangeAlteringEditor<T: RangeReplaceableCollection>: RangeAlteringEditor where T.IndexDistance == Int {
    
    //MARK: Properties
    public let source: T
    private let editorDescription: String
    
    private let performer: (T) -> T
    private let tableEdit: (Int, UITableView) -> Void
    private let collectionEdit: (Int, UICollectionView) -> Void
    
    public let isAdditive: Bool
    public let alteredElement: T.Iterator.Element
    public let alteredIndex: T.Index
    
    //MARK: Initializers
    init<E: RangeAlteringEditor>(editor: E) where E.EditedType == T {
        source = editor.source
        editorDescription = editor.description
        
        performer = editor.perform
        tableEdit = editor.edit
        collectionEdit = editor.edit
        
        alteredElement = editor.alteredElement
        isAdditive = editor.isAdditive
        alteredIndex = editor.alteredIndex
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
