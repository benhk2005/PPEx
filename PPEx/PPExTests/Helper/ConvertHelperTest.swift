//
//  ConvertHelperTest.swift
//  PPExTests
//
//  Created by Ben Leung on 6/12/2020.
//

import XCTest
@testable import PPEx


class ConvertHelperTest: XCTestCase {
    
    func testConvertUSDtoUSD() {
        XCTAssertTrue(ConvertHelper.convert(input: Decimal(12.0), baseCurrency: "USD", targetCurrency: "USD", baseExchangeRate: Decimal(1.0), targetExchangeRate: Decimal(1.0)).isEqual(to: Decimal(12.0)))
    }
    
    func testConvertUSDtoJPY() {
        XCTAssertTrue(ConvertHelper.convert(input: Decimal(33.2), baseCurrency: "USD", targetCurrency: "JPY", baseExchangeRate: Decimal(1.0), targetExchangeRate: Decimal(104.522962)).isEqual(to: Decimal(3470.1623384)))
    }
    
    func testConvertJPYtoHKD() {
        let result = ConvertHelper.convert(input: Decimal(100.0), baseCurrency: "JPY", targetCurrency: "HKD", baseExchangeRate: Decimal(104.522962), targetExchangeRate: Decimal(7.75158))
        
        XCTAssertTrue((result - Decimal(7.4161)) < 0.01)
    }
    
}
