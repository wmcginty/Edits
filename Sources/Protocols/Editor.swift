//
//  Editor.swift
//  Edits
//
//  Created by William McGinty on 11/9/16.
//
//

import Foundation

/// An object capable of transforming a collection in a pre-defined way.
public protocol Editor: CustomStringConvertible {
    
    associatedtype EditedType: Collection where EditedType.Element: Equatable
    
    /// Performs the editors specific transformation. Leaves the input unaffected.
    ///
    /// - Parameter input: The source of the edit. Is unaffected by the transformation.
    /// - Returns: The output of this single transformation.
    func perform(with input: EditedType) -> EditedType
    
    func edit(forSection section: Int, in tableView: UITableView)
    func edit(forSection section: Int, in collectionView: UICollectionView)
}

/// A type-erased wrapper struct around the Deletion, Insertion, Substitution and Movement edits. While their individual type can not be queried, their edit can be performed on any input.
public struct AnyEditor<T: RangeReplaceableCollection>: Editor where T.Element: Equatable {
    
    // MARK: Properties
    private let editorDescription: String
    
    private let performer: (T) -> T
    private let tableEdit: (Int, UITableView) -> Void
    private let collectionEdit: (Int, UICollectionView) -> Void
    
    // MARK: Initializers
    init<E: Editor>(editor: E) where E.EditedType == T {
        editorDescription = editor.description
        
        performer = editor.perform
        tableEdit = editor.edit
        collectionEdit = editor.edit
    }
    
    // MARK: CustomStringConvertible
    public var description: String { return editorDescription }
    
    // MARK: Editor
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
