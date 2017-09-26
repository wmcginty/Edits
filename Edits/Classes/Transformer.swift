//
//  Transformer.swift
//  Edits
//
//  Created by William McGinty on 11/7/16.
//
//

import Foundation

public class Transformer<T: RangeReplaceableCollection> where T.IndexDistance == Int, T.Iterator.Element: Equatable {
    
    //MARK: Properties
    let sourceCollection: T
    let destinationCollection: T
    private lazy var editMatrix: TransformMatrix = Transformer.editDistanceMatrix(from: self.sourceCollection,
                                                                                  to: self.destinationCollection)
    
    //MARK: Initializers
    public init(source: T, destination: T) {
        sourceCollection = source
        destinationCollection = destination
    }

    //MARK: Computed Variables
    public var minEditDistance: Int { return editSteps.count }
    public lazy var editSteps: [AnyEditor<T>] = Transformer.edits(from: self.sourceCollection, to: self.destinationCollection, with: self.editMatrix)
}

//MARK: Interface
extension Transformer {
    
    static func editDistanceMatrix(from source: T, to destination: T) -> TransformMatrix {
        let rows = source.count
        let columns = destination.count
        var editDistances = TransformMatrix(rows: rows + 1, columns: columns + 1)
        
        for row in 1...rows {
            for column in 1...columns {
                
                let coordinate = Coordinate(row: row, column: column)
                let sourceComponent = source.element(atOffsetFromStartIndex: row - 1)
                let destinationComponent = destination.element(atOffsetFromStartIndex: column - 1)
                
                let update = editCount(for: coordinate, in: editDistances, whenComponentsEqual: sourceComponent == destinationComponent)
                editDistances.set(value: update, at: coordinate)
            }
        }
        
        return editDistances
    }
    
    static func edits(from source: T, to destination: T, with matrix: TransformMatrix) -> [AnyEditor<T>] {
        var edits: [AnyEditor<T>] = []
        var rangeAlteringEdits: [AnyRangeAlteringEditor<T>] = []
        var coordinate = matrix.end
        
        while matrix.value(for: coordinate) > 0 {
            if coordinate.row > 0 && coordinate.column > 0 && source.element(atOffsetFromStartIndex: coordinate.row - 1) == destination.element(atOffsetFromStartIndex: coordinate.column - 1) {
                //The two elements are the same, no edit required. Move diagonally up the matrix and repeat.
                coordinate = coordinate.inPreviousRow.inPreviousColumn
                
            } else {
                
                switch minimumEditCount(neighboring: coordinate, in: matrix) {
                case matrix[coordinate.inPreviousRow] where coordinate.row > 0:
                    //It would be optimal to move UP the matrix (meaning a deletion)
                    coordinate = coordinate.inPreviousRow
                    rangeAlteringEdits.append(deletionEdit(from: source, for: coordinate))

                case matrix[coordinate.inPreviousColumn] where coordinate.column > 0:
                    //It would be optimal to move LEFT in the matrix (meaning an insertion)
                    coordinate = coordinate.inPreviousColumn
                    rangeAlteringEdits.append(insertionEdit(into: destination, for: coordinate))
                    
                case _ where coordinate.row > 0 && coordinate.column > 0:
                    //It would be optimal to move DIAGONALLY UP the matrix (meaning a substitution)
                    coordinate = coordinate.inPreviousRow.inPreviousColumn
                    edits.append(substitutionEdit(from: source, into: destination, for: coordinate))

                default: continue
                }
            }
        }
        
        return edits + condensedRangeAlteringEdits(from: rangeAlteringEdits)
    }
}

//MARK: Editor Creation
private extension Transformer {
    
    static func deletionEdit(from source: T, for coordinate: Coordinate) -> AnyRangeAlteringEditor<T> {
        guard let element = source.element(atOffsetFromStartIndex: coordinate.row),
            let index = source.index(source.startIndex, offsetBy: coordinate.row, limitedBy: source.endIndex) else {
                fatalError("Logic error - we have calculated a coordinate that should not exist")
        }
        
        return AnyRangeAlteringEditor(editor: Deletion(source: source, deleted: element, atIndex: index))
    }
    
    static func insertionEdit(into source: T, for coordinate: Coordinate) -> AnyRangeAlteringEditor<T> {
        guard let element = source.element(atOffsetFromStartIndex: coordinate.column),
            let index = source.index(source.startIndex, offsetBy: coordinate.column, limitedBy: source.endIndex) else {
                fatalError("Logic error - we have calculated a coordinate that should not exist")
        }
        
        return AnyRangeAlteringEditor(editor: Insertion(source: source, inserted: element, atIndex: index))
    }
    
    static func substitutionEdit(from source: T, into destination: T, for coordinate: Coordinate) -> AnyEditor<T> {
        guard let removed = source.element(atOffsetFromStartIndex: coordinate.row), let inserted = destination.element(atOffsetFromStartIndex: coordinate.column),
            let index = source.index(source.startIndex, offsetBy: coordinate.row, limitedBy: source.endIndex) else {
                fatalError("Logic error - we have calculated a coordinate that should not exist")
        }
        
        return AnyEditor(editor: Substitution(source: source, from: removed, to: inserted, atIndex: index))
    }
    
    static func movementEdit(from lhs: AnyRangeAlteringEditor<T>, and rhs: AnyRangeAlteringEditor<T>) -> AnyEditor<T>? {
        guard lhs.isAdditive == !rhs.isAdditive && lhs.alteredElement == rhs.alteredElement else { return nil }
        
        let sourceIndex = !lhs.isAdditive ? lhs.alteredIndex : rhs.alteredIndex
        let destIndex = lhs.isAdditive ? lhs.alteredIndex : rhs.alteredIndex
        
        let move = Movement(source: lhs.source, move: lhs.alteredElement, fromIndex: sourceIndex, toIndex: destIndex)
        return AnyEditor(editor: move)
    }
}

//MARK: Helper
private extension Transformer {
    
    static func editCount(for coordinate: Coordinate, in matrix: TransformMatrix, whenComponentsEqual equal: Bool) -> Int {
        if equal {
            return matrix[coordinate.inPreviousRow.inPreviousColumn]
        } else {
            return minimumEditCount(neighboring: coordinate, in: matrix) + 1
        }
    }
    
    static func minimumEditCount(neighboring coordinate: Coordinate, in matrix: TransformMatrix) -> Int {
        switch (coordinate.row, coordinate.column) {
        case let (r, c) where r > 0 && c > 0: return min(matrix[coordinate.inPreviousRow], matrix[coordinate.inPreviousColumn], matrix[coordinate.inPreviousRow.inPreviousColumn])
        case let (r, _) where r > 0: return matrix[coordinate.inPreviousRow]
        case let (_, c) where c > 0: return matrix[coordinate.inPreviousColumn]
        default: return 0
        }
    }
}

//MARK: Movement Processing
private extension Transformer {
    
    static func condensedRangeAlteringEdits(from edits: [AnyRangeAlteringEditor<T>]) -> [AnyEditor<T>] {
        var rangeAlteringEdits = [AnyEditor<T>]()
        var insertions = edits.filter { $0.isAdditive }
        var deletions = edits.filter { !$0.isAdditive }
        
        for (i, insertion) in insertions.enumerated() {
            for (j, deletion) in deletions.enumerated() {
                if let movementEdit = movementEdit(from: insertion, and: deletion) {
                    
                    //We've created a movement by combining an insertion and deletion - modify our data store accordingly
                    rangeAlteringEdits.append(movementEdit)
                    deletions.remove(at: j)
                    insertions.remove(at: i)
                    
                    break
                }
            }
        }
        
        return rangeAlteringEdits + insertions.map { AnyEditor(editor: $0) } + deletions.map { AnyEditor(editor: $0) }
    }
}

