//
//  LocalDataHelperTest.swift
//  PPExTests
//
//  Created by Ben Leung on 5/12/2020.
//

import XCTest
@testable import PPEx

class LocalDataHelperTest: XCTestCase {

    var localDataHelper: LocalDataHelper!
    var userDefault: UserDefaults!
    
    override func setUp() {
        userDefault = UserDefaults()
        localDataHelper = LocalDataHelper(userDefaults: userDefault)
    }
    
    override func tearDown() {
        resetUserDefault()
        localDataHelper = nil
        userDefault = nil
    }
    
    func resetUserDefault() {
        let dict = userDefault.dictionaryRepresentation()
        dict.keys.forEach { (key) in
            userDefault.removeObject(forKey: key)
        }
    }
    
    func testCurrenciesListNewlyCreatedUpdateTime(){
        resetUserDefault()
        XCTAssertTrue(localDataHelper.shouldRetreieveCurrenciesFromNetwork())
    }
    
    func testCurrenciesListWithin30Mins() {
        userDefault.setValue(Date().addingTimeInterval(-15 * 60).timeIntervalSince1970, forKey: LocalDataKey.currencyLastUpdateTimeKey)
        XCTAssertFalse(localDataHelper.shouldRetreieveCurrenciesFromNetwork())
    }
    
    func testCurrenciesListOutOf30Mins() {
        userDefault.setValue(Date().addingTimeInterval(31 * 60).timeIntervalSince1970, forKey: LocalDataKey.currencyLastUpdateTimeKey)
        XCTAssertTrue(localDataHelper.shouldRetreieveCurrenciesFromNetwork())
    }
    
    func testSaveLoadCurrenciesList(){
        let currencies = ["USD", "JPY", "HKD", "CNY", "GBP"]
        localDataHelper.saveCurrenciesList(currencies: currencies)
        XCTAssertEqual(currencies.sorted(), localDataHelper.loadCurrenciesList())
    }
    
    func testExchangeRateNewlyCreatedUpdateTime(){
        resetUserDefault()
        XCTAssertTrue(localDataHelper.shouldRetreieveExchangeRateFromNetwork())
    }
    
    func testExchangeRateWithin30Mins() {
        userDefault.setValue(Date().addingTimeInterval(-15 * 60).timeIntervalSince1970, forKey: LocalDataKey.exchangeRateLastUpdateTimeKey)
        XCTAssertFalse(localDataHelper.shouldRetreieveExchangeRateFromNetwork())
    }
    
    func testExchangeRateOutOf30Mins() {
        userDefault.setValue(Date().addingTimeInterval(31 * 60).timeIntervalSince1970, forKey: LocalDataKey.exchangeRateLastUpdateTimeKey)
        XCTAssertTrue(localDataHelper.shouldRetreieveExchangeRateFromNetwork())
    }
    
    func testCurrencyExchangeInfo() {
        localDataHelper.saveCurrencyExchangeInfo(currencySymbol: "USD", rate: Decimal(string: "7.8")!)
        let retrieveDecimal = localDataHelper.getCurrencyExchangeInfo(currencySymbol: "USD")
        XCTAssertTrue((Decimal(7.8) - retrieveDecimal!) < 0.1)
        //Include the error for floating point
    }

}
