//
//  CurrenciesInterface.swift
//  PPEx
//
//  Created by Ben Leung on 3/12/2020.
//

import UIKit


protocol CurrenciesViewInterface {
    
    var presenter: CurrenciesPresenterInterface? { get set }
    
    func showCurrenciesPicker()
    
    func setupView()
    
    func refreshExchangeRate()
    
    func showLoading()
    
    func hideLoading()
    
    func showErrorMsg(message: String)
    
    func updateCurrencyDropDownView(currency: String)
    
}

protocol CurrenciesInteractorInterface {
    
    var presenter: CurrenciesPresenterInterface? { get set }
    
    func fetchCurrenciesListFromAPI(completion: @escaping ((Result<[String], APIError>)->Void))
    
    func isCurrenciesListReady() -> Bool
    
    func loadCurrenciesListFromCache() -> [String]?
    
    func saveCurrenciesListToCache(currenciesList: [String])
    
    func updateCurrenciesListUpdateTime()
    
    func isExchangeRateReady() -> Bool
    
    func convertRate(input: Decimal, baseCurrency: String, targetCurrency: String) -> String?
    
    func fetchExchangeRateFromAPI(completion: @escaping ((Result<[String:Float], APIError>)->Void))
    
    func updateExchangeRateUpdateTime()
    
    func getExchangeRate(currencyName: String) -> Decimal?
    
    func saveExchangeRate(exchangeRate: [String:Float])
    
}

protocol CurrenciesPresenterInterface {
    
    var interactor: CurrenciesInteractorInterface? { get set }
    
    var viewController: CurrenciesViewInterface? { get set }
    
    func viewIsReady()
    
    func currenciesListIsReady() -> Bool
    
    func calculateGridSize(numOfColumns: Int) -> CGSize
    
    func loadCurrenciesList(completion: @escaping ((Result<[String], APIError>)->Void))
    
    func currentDropDownViewDidClick()
    
    func getCurrenciesListFromCache() -> [String]
    
    func convertRate(targetCurrency: String) -> String?
    
    func getSelectedCurrencyIndex() -> Int
    
    func selectCurrencyCandidate(currency:String?)
    
    func replaceCurrencyWithCandidate()
    
    func updateEntryValue(decimal: Decimal)
    
}
