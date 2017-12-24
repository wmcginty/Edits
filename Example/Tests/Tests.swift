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
        let str = "hello"
        let i = Insertion(source: str, inserted: "h", atIndex: str.startIndex)
        XCTAssertEqual(i.perform(with: "hello"), "hhello")
    }
}
