//
//  CurrenciesPresenterTest.swift
//  PPExTests
//
//  Created by Ben Leung on 6/12/2020.
//

import XCTest
@testable import PPEx

class CurrenciesPresenterTest: XCTestCase {
    
    var presenter: CurrenciesPresenter!
    var viewController: CurrenciesViewControllerSpy!
    var interactor: CurrenciesInteractorSpy!
    
    override func setUp() {
        presenter = CurrenciesPresenter()
        viewController = CurrenciesViewControllerSpy()
        interactor = CurrenciesInteractorSpy()
        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.interactor = interactor
    }
    
    override func tearDown() {
        presenter = nil
        viewController = nil
        interactor = nil
    }
    
    func testViewIsReady(){
        let currencies = ["HKD", "BTC", "ETH", "KRW"]
        interactor.currencyListCompletionSuccessVal = currencies
        
        var exchangeRate = [String:Float]()
        exchangeRate["HKD"] = Float(7.8)
        exchangeRate["JPY"] = Float(102)
        interactor.exchangeCompletionSuccessVal = exchangeRate
        
        presenter.viewIsReady()
        XCTAssertTrue(viewController.setupViewCalled)
        XCTAssertTrue(viewController.showLoadingCalled)
    }
    
    func testGetCurrenciesListFromCacheNil() {
        interactor.currenciesList = nil
        XCTAssertEqual(presenter.getCurrenciesListFromCache(), [])
    }
    
    func testGetCurrenciesListFromCacheNonNil() {
        let currencyList = ["USD", "HKD", "JPY"]
        interactor.currenciesList = currencyList
        XCTAssertEqual(presenter.getCurrenciesListFromCache(), currencyList)
    }
    
    func testConvertRate() {
        interactor.convertRateValue = "Test Rate"
        XCTAssertEqual(presenter.convertRate(targetCurrency: "HKD"), "Test Rate")
    }
    
    func testGetSelectedCurrencyIndexExist() {
        let currencyList = ["USD", "HKD", "JPY"]
        interactor.currenciesList = currencyList
        presenter.selectedCurrency = "JPY"
        XCTAssertEqual(presenter.getSelectedCurrencyIndex(), 2)
    }
    
    func testGetSelectedCurrencyIndexNotExist() {
        let currencyList = ["USD", "HKD", "JPY"]
        interactor.currenciesList = currencyList
        presenter.selectedCurrency = "CNY"
        XCTAssertEqual(presenter.getSelectedCurrencyIndex(), 0)
    }
    
    func testSelectCurrencyCandidate1() {
        presenter.selectCurrencyCandidate(currency: "HKD")
        XCTAssertEqual(presenter.selectedCurrencyCandidate, "HKD")
    }
    
    func testSelectCurrencyCandidate2() {
        presenter.selectCurrencyCandidate(currency: "HKD")
        presenter.selectCurrencyCandidate(currency: nil)
        XCTAssertEqual(presenter.selectedCurrencyCandidate, "HKD")
    }
    
    func testSelectCurrencyCandidate3() {
        presenter.selectCurrencyCandidate(currency: nil)
        presenter.selectCurrencyCandidate(currency: "JPY")
        XCTAssertEqual(presenter.selectedCurrencyCandidate, "JPY")
    }
    
    func testReplaceCurrencyWithCandidate1() {
        viewController.updateCurrencyDropDownViewCalledVal = nil
        presenter.selectCurrencyCandidate(currency: "HKD")
        presenter.replaceCurrencyWithCandidate()
        XCTAssertTrue(viewController.refreshExchangeRateCalled)
        XCTAssertTrue(viewController.updateCurrencyDropDownViewCalled)
        XCTAssertEqual(viewController.updateCurrencyDropDownViewCalledVal, "HKD")
    }
    
    func testReplaceCurrencyWithCandidate2() {
        viewController.updateCurrencyDropDownViewCalledVal = nil
        presenter.selectCurrencyCandidate(currency: nil)
        presenter.replaceCurrencyWithCandidate()
        XCTAssertFalse(viewController.refreshExchangeRateCalled)
        XCTAssertFalse(viewController.updateCurrencyDropDownViewCalled)
        XCTAssertNil(viewController.updateCurrencyDropDownViewCalledVal)
    }
    
    func testUpdateEntryValue() {
        presenter.updateEntryValue(decimal: Decimal(98.33))
        XCTAssertEqual(presenter.entryValue, Decimal(98.33))
        XCTAssertTrue(viewController.refreshExchangeRateCalled)
    }
    
    func testCurrentDropDownViewDidClickDataNotReady() {
        viewController.showErrorMsgCalledMessage = nil
        interactor.currenciesListReadyValue = false
        presenter.currentDropDownViewDidClick()
        XCTAssertTrue(viewController.showErrorMsgCalled)
        XCTAssertEqual(viewController.showErrorMsgCalledMessage, "Unable to get currencies list. Please check network connection and restart app to try again")
    }
    
    func testCurrentDropDownViewDidClickDataReady() {
        interactor.currenciesListReadyValue = true
        presenter.currentDropDownViewDidClick()
        XCTAssertTrue(viewController.showCurrenciesPickerCalled)
    }
    
    func testLoadExchangeRate() {
        interactor.exchangeRateReadyValue = true
        let ex = expectation(description: "Load Exchange Rate")
        presenter.loadExchangeRate { result in
            switch(result){
            case .success(_):
                XCTAssertTrue(true)
                break
            case .failure(_):
                XCTAssertTrue(false)
                break
            }
            ex.fulfill()
        }
        waitForExpectations(timeout: 3000)
    }
    
    func testLoadExchangeRateAPICallSuccess() {
        interactor.exchangeRateReadyValue = false
        interactor.exchangeCompletionSuccess = true
        var exchangeRate = [String:Float]()
        exchangeRate["HKD"] = Float(7.8)
        exchangeRate["JPY"] = Float(102)
        interactor.exchangeCompletionSuccessVal = exchangeRate
        
        let ex = expectation(description: "Load Exchange Rate")
        presenter.loadExchangeRate { result in
            switch(result){
            case .success(_):
                XCTAssertTrue(true)
                break
            case .failure(_):
                XCTAssertTrue(false)
                break
            }
            XCTAssertTrue(self.interactor.updateExchangeRateUpdateTimeCalled)
            ex.fulfill()
        }
        waitForExpectations(timeout: 3000)
    }
    
    func testLoadExchangeRateAPICallFail() {
        interactor.exchangeRateReadyValue = false
        interactor.exchangeCompletionSuccess = false
        interactor.exchangeCompletionFailError = APIError(errorMsg: "Mock API Error")
        
        let ex = expectation(description: "Load Exchange Rate")
        presenter.loadExchangeRate { result in
            switch(result){
            case .success(_):
                XCTAssertTrue(false)
                break
            case .failure(let error):
                XCTAssertEqual(error.errorMsg, "Mock API Error")
                XCTAssertTrue(true)
                break
            }
            XCTAssertFalse(self.interactor.updateExchangeRateUpdateTimeCalled)
            ex.fulfill()
        }
        waitForExpectations(timeout: 3000)
    }
    
    func testLoadCurrencyList() {
        interactor.currenciesListReadyValue = true
        let ex = expectation(description: "Load Currency List")
        presenter.loadCurrenciesList { result in
            switch(result){
            case .success(_):
                XCTAssertTrue(true)
                break
            case .failure(_):
                XCTAssertTrue(false)
                break
            }
            ex.fulfill()
        }
        waitForExpectations(timeout: 3000)
    }
    
    func testLoadCurrencyListWithAPISuccess() {
        interactor.currenciesListReadyValue = false
        interactor.currencyListCompletionSuccess = true
        let currencies = ["HKD", "BTC", "ETH", "KRW"]
        interactor.currencyListCompletionSuccessVal = currencies
        
        let ex = expectation(description: "Load Currency List")
        presenter.loadCurrenciesList { result in
            switch(result){
            case .success(let c):
                XCTAssertTrue(true)
                XCTAssertEqual(c, currencies)
                break
            case .failure(_):
                XCTAssertTrue(false)
                break
            }
            XCTAssertTrue(self.interactor.updateCurrenciesListUpdateTimeCalled)
            ex.fulfill()
        }
        waitForExpectations(timeout: 3000)
    }
    
    
    func testLoadCurrencyListWithAPIFail() {
        interactor.currenciesListReadyValue = false
        interactor.currencyListCompletionSuccess = false
        interactor.currencyListCompletionFailError = APIError(errorMsg: "Mock API Error 2")
        let ex = expectation(description: "Load Currency List")
        presenter.loadCurrenciesList { result in
            switch(result){
            case .success(_):
                XCTAssertTrue(false)
                break
            case .failure(let error):
                XCTAssertEqual(error.errorMsg, "Mock API Error 2")
                XCTAssertTrue(true)
                break
            }
            ex.fulfill()
        }
        waitForExpectations(timeout: 3000)
    }
    
    
}
