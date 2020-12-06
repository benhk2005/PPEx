//
//  LocalDataHelper.swift
//  PPEx
//
//  Created by Ben Leung on 5/12/2020.
//

import UIKit

class LocalDataHelper: LocalDataHelperInterface {
    
    let userDefaults:UserDefaults
    
    required init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func shouldRetreieveCurrenciesFromNetwork() -> Bool {
        guard let lastUpdateTime = userDefaults.object(forKey: LocalDataKey.currencyLastUpdateTimeKey) as? TimeInterval else {
            return true
        }
        let now = Date().timeIntervalSince1970
        return (lastUpdateTime > now) || (now - lastUpdateTime >= 30 * 3600)
    }
    
    func updateLastSuccessCurrenciesRetreievalTime() {
        userDefaults.set(Date().timeIntervalSince1970, forKey: LocalDataKey.currencyLastUpdateTimeKey)
        userDefaults.synchronize()
    }
    
    func resetLastSuccessCurrenciesRetreievalTime() {
        userDefaults.removeObject(forKey: LocalDataKey.currencyLastUpdateTimeKey)
        userDefaults.synchronize()
    }
    
    func saveCurrenciesList(currencies: [String]) {
        userDefaults.set(currencies, forKey: LocalDataKey.currencyListKey)
        userDefaults.synchronize()
    }
    
    func loadCurrenciesList() -> [String]? {
        var currencies = userDefaults.array(forKey: LocalDataKey.currencyListKey) as? [String]
        currencies?.sort()
        return currencies
    }
    
    func shouldRetreieveExchangeRateFromNetwork() -> Bool {
        guard let lastUpdateTime = userDefaults.object(forKey: LocalDataKey.exchangeRateLastUpdateTimeKey) as? TimeInterval else {
            return true
        }
        let now = Date().timeIntervalSince1970
        return (lastUpdateTime > now) || (now - lastUpdateTime >= 30 * 3600)
    }
    
    func updateLastSuccessExchangeRateRetreievalTime() {
        userDefaults.set(Date().timeIntervalSince1970, forKey: LocalDataKey.exchangeRateLastUpdateTimeKey)
        userDefaults.synchronize()
    }
    
    func resetLastSuccessExchangeRateRetreievalTime() {
        userDefaults.removeObject(forKey: LocalDataKey.exchangeRateLastUpdateTimeKey)
        userDefaults.synchronize()
    }
    
    func saveCurrencyExchangeInfo(currencySymbol: String, rate: Decimal) {
        userDefaults.set(rate, forKey: LocalDataKey.exchangeRatePrefix + currencySymbol)
        userDefaults.synchronize()
    }
    
    func getCurrencyExchangeInfo(currencySymbol: String) -> Decimal? {
        guard let rate = userDefaults.float(forKey: LocalDataKey.exchangeRatePrefix + currencySymbol) as? Float else { return nil }
        return Decimal(floatLiteral: Double(rate))
    }
    
    
}
