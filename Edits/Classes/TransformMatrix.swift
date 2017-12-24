//
//  TransformMatrix.swift
//  Edits
//
//  Created by William McGinty on 12/18/16.
//
//

import Foundation

public struct Coordinate {
    
    //MARK: Properties
    let row: Int
    let column: Int
    
    //MARK: Initializers
    public init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
    
    //MARK: Interface
    var inPreviousColumn: Coordinate {
        return Coordinate(row: row, column: max(0, column - 1))
    }
    
    var inPreviousRow: Coordinate {
        return Coordinate(row: max(0, row - 1), column: column)
    }
}

public struct TransformMatrix {
    
    //MARK: Properties
    fileprivate var storage: [[Int]]
    var end: Coordinate { return Coordinate(row: storage[0].count - 1, column: storage.count - 1) }
    
    //MARK: Initializers
    init(rows: Int, columns: Int) {
        var internalStore = [[Int]](repeating: [Int](repeating: 0, count: rows), count: columns)
        (0..<rows).forEach { internalStore[0][$0] = $0 }
        (0..<columns).forEach { internalStore[$0][0] = $0 }
        
        storage = internalStore
    }
}

//MARK: Interface
extension TransformMatrix {

    func value(for coordinate: Coordinate) -> Int {
        return storage[min(coordinate.column, max(0, storage.count - 1))][min(coordinate.row, max(0, storage[0].count - 1))]
    }
    
    mutating func set(value: Int, at coordinate: Coordinate) {
        storage[coordinate.column][coordinate.row] = value
    }
    
    subscript(coordinate: Coordinate) -> Int {
        return value(for: coordinate)
    }
}

//MARK: Custom String Convertible
extension TransformMatrix: CustomStringConvertible {
    
    public var description: String {
        let columnRange = 0..<(storage.first?.count ?? 1)
        let columnResult = columnRange.reduce("") { accum, row in
            let rowRange = 0..<storage.count
            let rowResult: String = rowRange.reduce("") {
                return $0 + "\(value(for: Coordinate(row: row, column: $1))) "
            }
            
            return accum + "\(rowResult)\n"
        }
        
        return columnResult
    }
}
