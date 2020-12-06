//
//  LocalDataHelperInterface.swift
//  PPEx
//
//  Created by Ben Leung on 5/12/2020.
//

import Foundation

protocol LocalDataHelperInterface {
    
    init (userDefaults: UserDefaults)
    
    func shouldRetreieveCurrenciesFromNetwork() -> Bool
    func updateLastSuccessCurrenciesRetreievalTime()
    
    func saveCurrenciesList(currencies: [String])
    func loadCurrenciesList() -> [String]?
    
    func saveCurrencyExchangeInfo(currencySymbol: String, rate: Decimal)
    func getCurrencyExchangeInfo(currencySymbol: String) -> Decimal?
    func shouldRetreieveExchangeRateFromNetwork() -> Bool
    
}

struct LocalDataKey {
    
    static let currencyListKey = "CURRENCY_LIST"
    static let currencyLastUpdateTimeKey = "CURRENCY_LIST_UPDATE_TIME"
    static let exchangeRatePrefix = "RATE-"
    static let exchangeRateLastUpdateTimeKey = "RATE_UPDATE_TIME"
    
}
