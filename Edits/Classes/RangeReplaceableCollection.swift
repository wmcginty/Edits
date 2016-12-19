//
//  RangeReplaceableCollection.swift
//  Pods
//
//  Created by William McGinty on 12/18/16.
//
//

import Foundation

extension RangeReplaceableCollection where IndexDistance == Int {
    
    func element(atOffsetFromStartIndex offset: IndexDistance) -> Iterator.Element? {
        if let idx = index(startIndex, offsetBy: offset, limitedBy: endIndex) {
            return self[idx]
        }
        
        return .none
    }
}
