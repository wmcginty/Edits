//
//  RangeReplaceableCollection+Offset.swift
//  Edits
//
//  Created by William McGinty on 12/18/16.
//
//

import Foundation

extension RangeReplaceableCollection {
    
    subscript(atOffset offset: Int) -> Element? {
        guard let index = index(atOffset: offset) else { return nil }
        return self[index]
    }
    
    func index(atOffset offset: Int) -> Index? {
        guard let i = index(startIndex, offsetBy: offset, limitedBy: endIndex), i < endIndex else { return nil }
        return i
    }
}
