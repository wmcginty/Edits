import UIKit
import XCTest
@testable import Edits

class Tests: XCTestCase {
    
    func testMatrixInitialization() {
        let m = TransformMatrix(rows: 3, columns: 3)
        XCTAssertEqual(0, m.value(for: Coordinate(row: 0, column: 0)))
        XCTAssertEqual(0, m.value(for: Coordinate(row: 1, column: 1)))
        XCTAssertEqual(0, m.value(for: Coordinate(row: 2, column: 2)))
    }
    
    func testMatrixPreviousRow() {
        XCTAssertEqual(Coordinate(row: 2, column: 2).inPreviousColumn.row, 2)
        XCTAssertEqual(Coordinate(row: 2, column: 2).inPreviousColumn.column, 1)
        
        XCTAssertEqual(Coordinate(row: 2, column: 2).inPreviousRow.row, 1)
        XCTAssertEqual(Coordinate(row: 2, column: 2).inPreviousRow.column, 2)
    }
    
    func testEndOfMatrix() {
        var m = TransformMatrix(rows: 5, columns: 5)
        m.set(value: 5, at: m.end)
        XCTAssertEqual(5, m.value(for: m.end))
    }
    
    func testInsertion() {
        let i = Insertion<String>(inserted: "h", atIndexOffset: 4)
        XCTAssertEqual(i.perform(with: "hello"), "hellho")
        
        let i2 = Insertion<String>(inserted: "h", atIndexOffset: 0)
        XCTAssertEqual(i2.perform(with: "hello"), "hhello")
        
        let i3 = Insertion<String>(inserted: "h", atIndexOffset: 5)
        XCTAssertEqual(i3.perform(with: "hello"), "helloh")
    }
    
    func testInsertionEquality() {
        let i1 = Insertion<String>(inserted: "a", atIndexOffset: 0)
        let i2 = Insertion<String>(inserted: "a", atIndexOffset: 0)
        let i3 = Insertion<String>(inserted: "b", atIndexOffset: 0)
        let i4 = Insertion<String>(inserted: "a", atIndexOffset: 1)
        
        XCTAssertEqual(i1, i2)
        XCTAssertNotEqual(i2, i3)
        XCTAssertNotEqual(i2, i4)
    }
    
    func testDeletion() {
        let d = Deletion<String>(deleted: "d", atIndexOffset: 3)
        XCTAssertEqual(d.perform(with: "abcd"), "abc")
        
        let d1 = Deletion<String>(deleted: "d", atIndexOffset: 0)
        XCTAssertEqual(d1.perform(with: "dam"), "am")
    }
    
    func testDeletionEquality() {
        let d1 = Deletion<String>(deleted: "a", atIndexOffset: 0)
        let d2 = Deletion<String>(deleted: "a", atIndexOffset: 0)
        let d3 = Deletion<String>(deleted: "b", atIndexOffset: 0)
        let d4 = Deletion<String>(deleted: "a", atIndexOffset: 1)
        
        XCTAssertEqual(d1, d2)
        XCTAssertNotEqual(d2, d3)
        XCTAssertNotEqual(d2, d4)
    }
    
    func testMovement() {
        let m = Movement<String>(move: "a", fromIndexOffset: 0, toIndexOffset: 3)
        XCTAssertEqual(m.perform(with: "abcde"), "bcdae")
        
        let m2 = Movement<String>(move: "a", fromIndexOffset: 1, toIndexOffset: 2)
        XCTAssertEqual(m2.perform(with: "bad"), "bda")
    }
    
    func testMovementEquality() {
        let m1 = Movement<String>(move: "a", fromIndexOffset: 0, toIndexOffset: 1)
        let m2 = Movement<String>(move: "a", fromIndexOffset: 0, toIndexOffset: 1)
        let m3 = Movement<String>(move: "b", fromIndexOffset: 0, toIndexOffset: 2)
        let m4 = Movement<String>(move: "b", fromIndexOffset: 2, toIndexOffset: 1)
        
        XCTAssertEqual(m1, m2)
        XCTAssertNotEqual(m2, m3)
        XCTAssertNotEqual(m2, m4)
    }
    
    func testSubstitution() {
        let s = Substitution<String>(from: "b", to: "d", atIndexOffset: 0)
        XCTAssertEqual(s.perform(with: "befg"), "defg")
        
        let s2 = Substitution<String>(from: "a", to: "f", atIndexOffset: 0)
        XCTAssertEqual(s2.perform(with: "abcd"), "fbcd")
    }
    
    func testSubstitutionEquality() {
        let s1 = Substitution<String>(from: "c", to: "d", atIndexOffset: 0)
        let s2 = Substitution<String>(from: "c", to: "d", atIndexOffset: 0)
        let s3 = Substitution<String>(from: "c", to: "d", atIndexOffset: 1)
        let s4 = Substitution<String>(from: "d", to: "c", atIndexOffset: 0)
        
        XCTAssertEqual(s1, s2)
        XCTAssertNotEqual(s2, s3)
        XCTAssertNotEqual(s2, s4)
    }
    
    func testBasicTransforms() {
        let a = [1,2,3,4,5]
        let b = [2,3,4,5,1]
        let t = Transformer(source: a, destination: b)
        XCTAssertEqual(t.minEditDistance, 1)
        XCTAssert(t.editSteps.first!.description.contains("Move"))
        
        let a2 = [1,2,3,4,5]
        let b2 = [2,3,4,5,6]
        let t2 = Transformer(source: a2, destination: b2)
        XCTAssertEqual(t2.minEditDistance, 2)
    }
    
    func testAnyEditorPerform() {
        let e = AnyEditor<String>(editor: Insertion(inserted: "a", atIndexOffset: 0))
        XCTAssertEqual(e.perform(with: "bcd"), "abcd")
        
        let e2 = AnyEditor<String>(editor: Deletion(deleted: "d", atIndexOffset: 3))
        XCTAssertEqual(e2.perform(with: "abcd"), "abc")
    }
    
    func testAnyRangeAlteringEditor() {
        let e = AnyRangeAlteringEditor<String>(editor: Insertion(inserted: "a", atIndexOffset: 0))
        XCTAssertTrue(e.isAdditive)
        XCTAssertEqual(e.perform(with: "bcd"), "abcd")
        
        let e2 = AnyRangeAlteringEditor<String>(editor: Deletion(deleted: "a", atIndexOffset: 0))
        XCTAssertFalse(e2.isAdditive)
        XCTAssertEqual(e2.perform(with: "abcd"), "bcd")
        
    }
}
