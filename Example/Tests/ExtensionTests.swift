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
        let a = [1,2,3,4,5,6,7,8]
        let results = a.bifilter { $0 % 2 == 0 }
        XCTAssertEqual(results.included, [2,4,6,8])
        XCTAssertEqual(results.notIncluded, [1,3,5,7])
    }
    
    func testRangeReplaceableCollectionOffset() {
        let a = [1,2,3,4,5]
        
        for i in a.indices {
            XCTAssertEqual(a.element(atOffsetFromStartIndex: i), a[i])
        }
    }
    
    
    
}
