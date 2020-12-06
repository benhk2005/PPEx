//
//  FormattingHelperTest.swift
//  PPExTests
//
//  Created by Ben Leung on 6/12/2020.
//

import XCTest
@testable import PPEx

class FormattingHelperTest: XCTestCase {
    
    func testFormat1() {
        XCTAssertEqual(FormattingHelper.formatDecimalToString(decimal: Decimal(123.45), decimalPoint: 0), "123")
    }
    
    func testFormat2() {
        XCTAssertEqual(FormattingHelper.formatDecimalToString(decimal: Decimal(123.56), decimalPoint: 0), "124")
    }
    
    func testFormat3() {
        XCTAssertEqual(FormattingHelper.formatDecimalToString(decimal: Decimal(123.444), decimalPoint: 1), "123.4")
    }
    
    func testFormat4() {
        XCTAssertEqual(FormattingHelper.formatDecimalToString(decimal: Decimal(0.33445), decimalPoint: 8), "0.33445")
    }
    
    func testFormat5() {
        XCTAssertEqual(FormattingHelper.formatDecimalToString(decimal: Decimal(11.123456789), decimalPoint: 8), "11.12345679")
    }
    
}
