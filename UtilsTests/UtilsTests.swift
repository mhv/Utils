//
//  UtilsTests.swift
//  UtilsTests
//
//  Created by Mikhail Vroubel on 9/20/15.
//  Copyright © 2015 Mikhail Vroubel. All rights reserved.
//

import XCTest
@testable import Utils

class Some: Memoable {
    class func memoKey()->String {
        return "Some"
    }
}
class Other: Some {
    override class func memoKey()->String {
        return "Other"
    }
}

class UtilsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSparseArray() {
        var a = SparseArray<Int>()
        _ = a.append(10)
        let i = a.append(20)
        _ = a.append(30)
        a.removeAtIndex(i)
        var keys = [Int]()
        var vals = [Int]()
        for (i,v) in a {
            keys.append(i)
            vals.append(v)
        }
        XCTAssert(keys == [0,2])
        XCTAssert(vals == [10,30])
    }
    
    func testMemoable() {
        let a = Some()
        let b = Other()
        a.setMemo("name")
        b.setMemo("name")
        XCTAssert(Some.memo("no name") == nil)
        XCTAssert(Other.memo("name") === b)
        XCTAssert(Some.memo("name") === a)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
