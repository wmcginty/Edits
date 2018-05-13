//
//  InterfaceTests.swift
//  Edits_Example
//
//  Created by William McGinty on 12/24/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import XCTest
@testable import Edits

class InterfaceTests: XCTestCase {
    
    func testInsertIndexPathGeneration() {
        XCTAssertEqual(Insertion<String>(inserted: "b", atIndexOffset: 1).affectedIndexPath(forSection: 0), IndexPath(item: 1, section: 0))
        XCTAssertEqual(Insertion<String>(inserted: "b", atIndexOffset: 1).affectedIndexPath(forSection: 1), IndexPath(item: 1, section: 1))
    }
    
    func testDeleteIndexPathGeneration() {
        XCTAssertEqual(Deletion<String>(deleted: "b", atIndexOffset: 3).affectedIndexPath(forSection: 0), IndexPath(item: 3, section: 0))
        XCTAssertEqual(Deletion<String>(deleted: "b", atIndexOffset: 3).affectedIndexPath(forSection: 1), IndexPath(item: 3, section: 1))
    }
    
    func testMoveIndexPathGeneration() {
        XCTAssertEqual(Movement<String>(move: "a", fromIndexOffset: 0, toIndexOffset: 1).sourceIndexPath(forSection: 0), IndexPath(item: 0, section: 0))
        XCTAssertEqual(Movement<String>(move: "a", fromIndexOffset: 0, toIndexOffset: 1).destinationIndexPath(forSection: 0), IndexPath(item: 1, section: 0))
        XCTAssertEqual(Movement<String>(move: "a", fromIndexOffset: 0, toIndexOffset: 1).sourceIndexPath(forSection: 1), IndexPath(item: 0, section: 1))
        XCTAssertEqual(Movement<String>(move: "a", fromIndexOffset: 0, toIndexOffset: 1).destinationIndexPath(forSection: 1), IndexPath(item: 1, section: 1))
    }
    
    func testSubstitutionIndexPathGeneration() {
        XCTAssertEqual(Substitution<String>(from: "a", to: "b", atIndexOffset: 5).affectedIndexPath(forSection: 0), IndexPath(item: 5, section: 0))
        XCTAssertEqual(Substitution<String>(from: "a", to: "b", atIndexOffset: 5).affectedIndexPath(forSection: 1), IndexPath(item: 5, section: 1))
    }
    
    func testInsertTableEdits() {
        let table = TableView()
        let t = Transformer(source: [1, 2, 3], destination: [1, 2, 3, 4, 5])
        table.processUpdates(for: t, inSection: 0)
        XCTAssertEqual(Set(table.insertedRows), Set([IndexPath(item: 4, section: 0), IndexPath(item: 3, section: 0)]))
    }
    
    func testInsertCollectionEdits() {
        let c = CollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let t = Transformer(source: [1, 2, 3], destination: [1, 2, 3, 4, 5])
        c.processUpdates(for: t, inSection: 0)
        XCTAssertEqual(Set(c.insertedItems), Set([IndexPath(item: 3, section: 0), IndexPath(item: 4, section: 0)]))
    }
    
    func testDeleteTableEdits() {
        let table = TableView()
        let t = Transformer(source: [1, 2, 3], destination: [3])
        table.processUpdates(for: t, inSection: 0)
        XCTAssertEqual(Set(table.deletedRows), Set([IndexPath(item: 1, section: 0), IndexPath(item: 0, section: 0)]))
    }
    
    func testDeleteCollectionEdits() {
        let c = CollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let t = Transformer(source: [1, 2, 3], destination: [3])
        c.processUpdates(for: t, inSection: 0)
        XCTAssertEqual(Set(c.deletedItems), Set([IndexPath(item: 1, section: 0), IndexPath(item: 0, section: 0)]))
    }
    
    func testMoveTableEdits() {
        let table = TableView()
        let t = Transformer(source: [1, 2, 3], destination: [2, 3, 1])
        table.processUpdates(for: t, inSection: 0)
        XCTAssertEqual(table.lastMoveSourceRow, IndexPath(item: 0, section: 0))
        XCTAssertEqual(table.lastMoveDestinationRow, IndexPath(item: 2, section: 0))
    }
    
    func testMoveCollectionEdits() {
        let c = CollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let t = Transformer(source: [1, 2, 3], destination: [2, 3, 1])
        c.processUpdates(for: t, inSection: 0)
        XCTAssertEqual(c.lastMoveSourceItem, IndexPath(item: 0, section: 0))
        XCTAssertEqual(c.lastMoveDestinationItem, IndexPath(item: 2, section: 0))
    }
    
    func testSubstituteTableEdits() {
        let table = TableView()
        let t = Transformer(source: [1, 2, 3], destination: [2, 2, 3])
        table.processUpdates(for: t, inSection: 0)
        XCTAssertEqual(table.reloadedRows, [IndexPath(item: 0, section: 0)])
    }
    
    func testSubstituteCollectionEdits() {
        let c = CollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let t = Transformer(source: [1, 2, 3], destination: [2, 2, 3])
        c.processUpdates(for: t, inSection: 0)
        XCTAssertEqual(c.reloadedItems, [IndexPath(item: 0, section: 0)])
    }
    
    // MARK: Test Structs
    private class TableView: UITableView {
        var reloadedRows: [IndexPath] = []
        var insertedRows: [IndexPath] = []
        var deletedRows: [IndexPath] = []
        
        var lastMoveSourceRow: IndexPath?
        var lastMoveDestinationRow: IndexPath?
        
        override func moveRow(at indexPath: IndexPath, to newIndexPath: IndexPath) {
            lastMoveSourceRow = indexPath
            lastMoveDestinationRow = newIndexPath
        }
        
        override func insertRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation) {
            insertedRows.append(contentsOf: indexPaths)
        }
        
        override func deleteRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation) {
            deletedRows.append(contentsOf: indexPaths)
        }
        
        override func reloadRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation) {
            reloadedRows.append(contentsOf: indexPaths)
        }
    }
    
    private class CollectionView: UICollectionView {
        var reloadedItems: [IndexPath] = []
        var insertedItems: [IndexPath] = []
        var deletedItems: [IndexPath] = []
        
        var lastMoveSourceItem: IndexPath?
        var lastMoveDestinationItem: IndexPath?
        
        override func moveItem(at indexPath: IndexPath, to newIndexPath: IndexPath) {
            lastMoveSourceItem = indexPath
            lastMoveDestinationItem = newIndexPath
        }
        
        override func insertItems(at indexPaths: [IndexPath]) {
            insertedItems.append(contentsOf: indexPaths)
        }
        
        override func deleteItems(at indexPaths: [IndexPath]) {
            deletedItems.append(contentsOf: indexPaths)
        }
        
        override func reloadItems(at indexPaths: [IndexPath]) {
            reloadedItems.append(contentsOf: indexPaths)
        }
    }
}
