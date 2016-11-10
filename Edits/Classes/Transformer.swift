//
//  Transformer.swift
//  Pods
//
//  Created by William McGinty on 11/7/16.
//
//

import Foundation

extension Collection where IndexDistance == Int {
    func element(at idx: Int) -> Iterator.Element? {
        return index(startIndex, offsetBy: idx, limitedBy: endIndex).map { self[$0] } ?? .none
    }
}

public class Transformer<T: RangeReplaceableCollection> where T.IndexDistance == Int, T.Iterator.Element: Equatable {
    
    let source: T
    let destination: T
    
    public init(source: T, destination: T) {
        self.source = source
        self.destination = destination
    }
    
    lazy var editDistances: [[Int]] = Transformer.editDistanceMatrix(from: self.source, to: self.destination)
    
    var minEditDistance: Int {
        return editDistances[Int(source.count)][Int(destination.count)]
    }
    
    lazy var editSteps: [AnyEditor<T>] = Transformer.editSteps(from: self.source, to: self.destination, withEditDistances: self.editDistances)
}

public extension Transformer {
    
    public static func editDistanceMatrix(from source: T, to destination: T) -> [[Int]] {
        
        let sourceLength = Int(source.count)
        let destinationLength = Int(destination.count)
        
        //TODO: That should be a seperated data structure (to abstract the arrayness)
        var editDistances = preparedEditDistanceMatrix(withRows: sourceLength, columns: destinationLength)
        
        for i in 1...destinationLength {
            for j in 1...sourceLength {
                
                //TODO: Seperate helper method? Internal methdo function?
                let sourceIndex = source.index(source.startIndex, offsetBy: i - 1, limitedBy: source.endIndex)!
                let destinationIndex = destination.index(destination.startIndex, offsetBy: j - 1, limitedBy: destination.endIndex)!
                
                let sourceComponent = source[sourceIndex]
                let destinationComponent = destination[destinationIndex]
                
                editDistances[i][j] = sourceComponent == destinationComponent ? editDistances[i - 1][j - 1] : minimumTransformCount(forRow: i, column: j, in: editDistances) + 1
            }
        }
        
        return editDistances
    }
    
    public static func editSteps(from source: T, to destination: T, withEditDistances editDistances: [[Int]]) -> [AnyEditor<T>] {
        
        var edits: [AnyEditor<T>] = []
        
        var row = Int(source.count)
        var column = Int(destination.count)
        
        while editDistances[row][column] > 0 {
            if row > 0 && column > 0 && source.element(at: row - 1) == destination.element(at: column - 1) {
                //If the letters are the same, no edit is needed. Move to the next letter (diagonally up the table)
                row -= 1; column -= 1
            } else {
                
                let minEditCount = minimumTransformCount(forRow: row, column: column, in: editDistances)
                if row > 0 && editDistances[row - 1][column] == minEditCount {
                    row -= 1
                    let deletion = Deletion<T>(deleted: source.element(at: row)!, index: source.index(source.startIndex, offsetBy: row, limitedBy: source.endIndex)!)
                    edits.append(AnyEditor(editor: deletion))
                } else if column > 0 && editDistances[row][column - 1] == minEditCount {
                    column -= 1
                    let insertion = Insertion<T>(inserted: destination.element(at: column)!, index: destination.index(destination.startIndex, offsetBy: column, limitedBy: destination.endIndex)!)
                    edits.append(AnyEditor(editor: insertion))
                    
                } else if row > 0 && column > 0 {
                    row -= 1; column -= 1
                    let substitution = Substitution<T>(from: source.element(at: row)!, to: destination.element(at: column)!, index: source.index(source.startIndex, offsetBy: row, limitedBy: source.endIndex)!)
                    edits.append(AnyEditor(editor: substitution))
                }
            }
        }
        
        return edits
    }
}

fileprivate extension Transformer {
    
    static func preparedEditDistanceMatrix(withRows rows: Int, columns: Int) -> [[Int]] {
        var result = [[Int]](repeating: [Int](repeating: 0, count: rows + 1), count: columns + 1)
        (0...rows).map { result[$0][0] = $0 }
        (0...columns).map { result[0][$0] = $0 }
        
        return result
    }
    
    static func minimumTransformCount(forRow row: Int, column: Int, in editDistances: [[Int]]) -> Int {
        switch (row, column) {
        case let (r, c) where r > 0 && c > 0: return min(editDistances[r - 1][c], editDistances[r][c - 1], editDistances[r - 1][c - 1])
        case let (r, c) where r > 0: return editDistances[r - 1][c]
        case let (r, c) where c > 0: return editDistances[r][c - 1]
        default: return 0
        }
    }
}

