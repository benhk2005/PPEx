//
//  CurrenciesInteractor.swift
//  PPEx
//
//  Created by Ben Leung on 4/12/2020.
//

import Foundation

class CurrenciesInteractor: CurrenciesInteractorInterface {
    
    var presenter: CurrenciesPresenterInterface?
    var apiHelper: APIHelper
    var localDataHelper: LocalDataHelper
    
    init(apiHelper: APIHelper, localDataHelper: LocalDataHelper){
        self.apiHelper = apiHelper
        self.localDataHelper = localDataHelper
    }
    
    func fetchCurrenciesListFromAPI(completion: @escaping ((Result<[String], APIError>)->Void)) {
        apiHelper.fetchCurrenciesList(completion: completion)
    }
    
    func isCurrenciesListReady() -> Bool {
        return !localDataHelper.shouldRetreieveCurrenciesFromNetwork()
    }
    
    func loadCurrenciesListFromCache() -> [String]?{
        return localDataHelper.loadCurrenciesList()
    }
    
    func saveCurrenciesListToCache(currenciesList: [String]) {
        localDataHelper.saveCurrenciesList(currencies: currenciesList)
    }
    
    func updateCurrenciesListUpdateTime() {
        localDataHelper.updateLastSuccessCurrenciesRetreievalTime()
    }
    
    func isExchangeRateReady() -> Bool {
        return !localDataHelper.shouldRetreieveExchangeRateFromNetwork()
    }
    
    func convertRate(input: Decimal, baseCurrency: String, targetCurrency: String) -> String? {
        guard let baseCurrencyExchangeRate = localDataHelper.getCurrencyExchangeInfo(currencySymbol: baseCurrency), let targetCurrencyExchangeRate = localDataHelper.getCurrencyExchangeInfo(currencySymbol: targetCurrency) else {
            return nil
        }
        return FormattingHelper.formatDecimalToString(decimal: ConvertHelper.convert(input: input, baseCurrency: baseCurrency, targetCurrency: targetCurrency, baseExchangeRate: baseCurrencyExchangeRate, targetExchangeRate: targetCurrencyExchangeRate), decimalPoint: Config.MAX_DECIMAL_POINT_FOR_AMOUNT)
    }
    
    func fetchExchangeRateFromAPI(completion: @escaping ((Result<[String : Float], APIError>) -> Void)) {
        return apiHelper.fetchExchangeRate(completion: completion)
    }
    
    func updateExchangeRateUpdateTime() {
        localDataHelper.updateLastSuccessExchangeRateRetreievalTime()
    }
    
    func getExchangeRate(currencyName: String) -> Decimal? {
        return localDataHelper.getCurrencyExchangeInfo(currencySymbol: currencyName)
    }
    
    func saveExchangeRate(exchangeRate: [String : Float]) {
        exchangeRate.forEach { (key, value) in
            var newKey = key
            if (key.starts(with: "USD")){
                newKey = String(key[String.Index.init(encodedOffset:3 )...])
            }
            localDataHelper.saveCurrencyExchangeInfo(currencySymbol: newKey, rate: Decimal(floatLiteral: Double(value)))
        }
    }
    
}
