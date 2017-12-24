//
//  Sequence+Bifilter.swift
//  Edits
//
//  Created by William McGinty on 12/24/17.
//

import Foundation

extension Sequence {
    
    func bifilter(_ isIncluded: (Element) throws -> Bool) rethrows -> (included: [Element], notIncluded: [Element]) {
        var included = [Element]()
        var notIncluded = [Element]()
        
        for element in self {
            guard try isIncluded(element) else { notIncluded.append(element); break }
            included.append(element)
        }
        
        return (included, notIncluded)
    }
}
