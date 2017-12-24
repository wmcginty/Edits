//
//  Editor.swift
//  Edits
//
//  Created by William McGinty on 11/9/16.
//
//

import Foundation

public protocol Editor: CustomStringConvertible  {
    
    associatedtype EditedType: Collection where EditedType.Element: Equatable
    
    var source: EditedType { get }
    func perform(with input: EditedType) -> EditedType
    
    func edit(forSection section: Int, in tableView: UITableView)
    func edit(forSection section: Int, in collectionView: UICollectionView)
}

public struct AnyEditor<T: RangeReplaceableCollection>: Editor where T.Element: Equatable {
    
    //MARK: Properties
    public let source: T
    private let editorDescription: String
    
    private let performer: (T) -> T
    private let tableEdit: (Int, UITableView) -> Void
    private let collectionEdit: (Int, UICollectionView) -> Void
    
    //MARK: Initializers
    init<E: Editor>(editor: E) where E.EditedType == T {
        source = editor.source
        editorDescription = editor.description
        
        performer = editor.perform
        tableEdit = editor.edit
        collectionEdit = editor.edit
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

