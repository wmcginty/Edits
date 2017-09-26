//
//  TransformMatrix.swift
//  Pods
//
//  Created by William McGinty on 12/18/16.
//
//

import Foundation

public struct Coordinate {
    
    let row: Int
    let column: Int
    
    public init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
    
    var previousColumn: Coordinate {
        return Coordinate(row: row, column: column - 1)
    }
    
    var previousRow: Coordinate {
        return Coordinate(row: row - 1, column: column)
    }
}

public struct TransformMatrix {
    
    //MARK: Properties
    fileprivate var storage: [[Int]]
    
    var end: Coordinate { return Coordinate(row: storage.first!.count - 1, column: storage.count - 1) }
    
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
        return storage[max(0, min(coordinate.column, storage.count - 1))][max(0, min(coordinate.row, storage[0].count - 1))]
    }
    
    mutating func set(value: Int, at coordinate: Coordinate) {
        storage[coordinate.column][coordinate.row] = value
    }
    
    subscript(coordinate: Coordinate) -> Int {
        get {
            return value(for: coordinate)
        }
    }
}

//MARK: Custom String Convertible
extension TransformMatrix: CustomStringConvertible {
    
    //TODO: This can be refined, depending on final requirements
    public var description: String {
        var result = "\n"
        for row in 0..<storage[0].count {
            for col in 0..<storage.count {
                result.append("\(value(for: Coordinate(row: row, column: col))) ")
            }
            result.append("\n")
        }
        
        return result
    }
}
