//
//  ExtensionTests.swift
//  Edits_Example
//
//  Created by William McGinty on 12/24/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import XCTest
@testable import Edits

class ExtensionTests: XCTestCase {
    
    func testBifilter() {
        let a = [1, 2, 3, 4, 5, 6, 7, 8]
        let results = a.bifilter { $0 % 2 == 0 }
        XCTAssertEqual(results.included, [2, 4, 6, 8])
        XCTAssertEqual(results.notIncluded, [1, 3, 5, 7])
    }
    
    func testCollectionElementAtOffset() {
        let a = [1, 2, 3, 4, 5]
        a.indices.forEach { XCTAssertEqual(a[atOffset: $0], a[$0]) }
    }
    
    func testCollectionElementAtOffsetNotStartingAtZero() {
        let a = NonZeroIndexCollection(elements: [1, 2, 3, 4, 5], offset: 2)
        a.indices.forEach { XCTAssertEqual(a[atOffset: $0], a[$0 + 2]) }
    }
    
    func testCollectionElementAtOffsetOutOfBounds() {
        let a = [1, 2, 3, 4, 5]
        XCTAssertNil(a[atOffset: a.count])
        XCTAssertNil(a[atOffset: a.count + 1])
    }
    
    private struct NonZeroIndexCollection<T>: RangeReplaceableCollection {
        let elements: [T]
        let offset: Int
        
        init(elements: [T], offset: Int) {
            self.elements = elements
            self.offset = offset
        }
        
        init() {
            self.init(elements: [], offset: 0)
        }
        
        var startIndex: Int { return elements.startIndex + offset }
        var endIndex: Int { return elements.startIndex + offset }
        func index(after i: Int) -> Int { return i + 1 }
        subscript(position: Int) -> T { return elements[position - offset] }
    }
}
