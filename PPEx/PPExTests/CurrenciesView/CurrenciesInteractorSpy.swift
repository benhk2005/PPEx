//
//  CurrenciesInteractorSpy.swift
//  PPExTests
//
//  Created by Ben Leung on 6/12/2020.
//

import Foundation
@testable import PPEx

class CurrenciesInteractorSpy: CurrenciesInteractorInterface {
    
    var presenter: CurrenciesPresenterInterface?
    
    var currenciesListReadyValue = false
    var currenciesList: [String]?
    var exchangeRateReadyValue = false
    var convertRateValue: String?
    var exchangeRateValue: Decimal?
    var exchangeCompletionSuccess = true
    var exchangeCompletionSuccessVal:[String:Float]!
    var exchangeCompletionFailError:APIError!
    var currencyListCompletionSuccess = true
    var currencyListCompletionSuccessVal:[String]!
    var currencyListCompletionFailError:APIError!
    var updateExchangeRateUpdateTimeCalled = false
    var updateCurrenciesListUpdateTimeCalled = false
    
    func fetchCurrenciesListFromAPI(completion: @escaping ((Result<[String], APIError>) -> Void)) {
        if (currencyListCompletionSuccess) {
            completion(.success(currencyListCompletionSuccessVal))
        } else {
            completion(.failure(currencyListCompletionFailError))
        }
    }
    
    func isCurrenciesListReady() -> Bool {
        return currenciesListReadyValue
    }
    
    func loadCurrenciesListFromCache() -> [String]? {
        return currenciesList
    }
    
    func saveCurrenciesListToCache(currenciesList: [String]) {
        
    }
    
    func updateCurrenciesListUpdateTime() {
        updateCurrenciesListUpdateTimeCalled = true
    }
    
    func isExchangeRateReady() -> Bool {
        return exchangeRateReadyValue
    }
    
    func convertRate(input: Decimal, baseCurrency: String, targetCurrency: String) -> String? {
        return convertRateValue
    }
    
    func fetchExchangeRateFromAPI(completion: @escaping ((Result<[String : Float], APIError>) -> Void)) {
        if (exchangeCompletionSuccess) {
            completion(.success(exchangeCompletionSuccessVal))
        } else {
            completion(.failure(exchangeCompletionFailError))
        }
    }
    
    func updateExchangeRateUpdateTime() {
        updateExchangeRateUpdateTimeCalled = true
    }
    
    func getExchangeRate(currencyName: String) -> Decimal? {
        return exchangeRateValue
    }
    
    func saveExchangeRate(exchangeRate: [String : Float]) {
        
    }
    
}
