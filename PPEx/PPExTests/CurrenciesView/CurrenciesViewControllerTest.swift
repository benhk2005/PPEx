//
//  CurrenciesViewControllerTest.swift
//  PPExTests
//
//  Created by Ben Leung on 6/12/2020.
//

import XCTest
@testable import PPEx

class CurrenciesViewControllerTest: XCTestCase {
    
    var viewController:CurrenciesViewController!
    var presenterSpy:CurrenciesPresenterSpy!
    
    override func setUp() {
        viewController = CurrenciesViewController()
        presenterSpy = CurrenciesPresenterSpy()
        viewController.presenter = presenterSpy
    }
    
    func testViewDidLoad() {
        viewController.viewDidLoad()
        XCTAssertTrue(presenterSpy.viewIsReadyCalled)
    }
    
    func testDropDownViewClicked() {
        viewController.currentDropDownViewDidClick()
        XCTAssertTrue(presenterSpy.currentDropDownViewDidClickCalled)
    }
    
    func testShowCurrenciesPicker() {
        viewController.showCurrenciesPicker()
        XCTAssertTrue(presenterSpy.getSelectedCurrencyIndexCalled)
    }
    
    func testCurrencyEntryNumberDidChanged(){
        viewController.currencyEntryNumberDidChanged(value: "10.0")
        XCTAssertTrue(presenterSpy.updateEntryValueCalled)
        XCTAssertEqual(presenterSpy.updateEntryDecimalValue, Decimal(10))
    }
    
    func testCurrencyEntryNumberDidChangedWrongValue(){
        viewController.currencyEntryNumberDidChanged(value: "---")
        XCTAssertTrue(presenterSpy.updateEntryValueCalled)
        XCTAssertEqual(presenterSpy.updateEntryDecimalValue, Decimal.zero)
    }
    
}
