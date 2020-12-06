//
//  CurrenciesPresenter.swift
//  PPEx
//
//  Created by Ben Leung on 4/12/2020.
//
import Foundation
import UIKit
import CoreGraphics

class CurrenciesPresenter: CurrenciesPresenterInterface {
    
    var viewController: CurrenciesViewInterface?
    var interactor: CurrenciesInteractorInterface?
    
    var entryValue: Decimal = Config.DEFAULT_ENTRY
    var selectedCurrency: String = Config.BASE_CURRENCY
    var selectedCurrencyCandidate: String?
    
    func viewIsReady() {
        viewController?.setupView()
        viewController?.showLoading()
        loadCurrenciesListAndExchangeRate()
    }
    
    func loadCurrenciesListAndExchangeRate() {
        loadCurrenciesList { (result) in
            switch(result){
            case .success(let currencies):
                self.interactor?.saveCurrenciesListToCache(currenciesList: currencies)
                self.loadExchangeRate()
                break
            case .failure(let error):
                self.viewController?.hideLoading()
                self.viewController?.showErrorMsg(message: error.errorMsg)
                break
            }
        }
    }
    
    func loadExchangeRate() {
        loadExchangeRate { result in
            switch(result) {
            case .success(let rate):
                self.viewController?.hideLoading()
                self.viewController?.refreshExchangeRate()
                break
            case .failure(let error):
                self.viewController?.hideLoading()
                self.viewController?.showErrorMsg(message: error.errorMsg)
                break
            }
        }
    }
    
    func currenciesListIsReady() -> Bool {
        return interactor?.isCurrenciesListReady() ?? false
    }
    
    func calculateGridSize(numOfColumns: Int) -> CGSize {
        let width = CGFloat(UIScreen.main.bounds.width / CGFloat(numOfColumns))
        return CGSize(width: width-16, height: width)
    }
    
    func currentDropDownViewDidClick() {
        if (currenciesListIsReady()){
            viewController?.showCurrenciesPicker()
        } else {
            viewController?.showErrorMsg(message: "Unable to get currencies list. Please check network connection and restart app to try again");
        }
    }
    
    func loadCurrenciesList(completion: @escaping ((Result<[String], APIError>)->Void)) {
        if (self.interactor?.isCurrenciesListReady() ?? false) {
            completion(.success(interactor?.loadCurrenciesListFromCache() ?? []))
        } else {
            interactor?.fetchCurrenciesListFromAPI (completion: {[weak self]result in
                guard let `self` = self else { return }
                switch(result){
                case .success(let currencies):
                    self.interactor?.updateCurrenciesListUpdateTime()
                    completion(.success(currencies))
                    break;
                case .failure(let error):
                    completion(.failure(error))
                    break;
                }
            })
        }
    }
    
    func loadExchangeRate(completion: @escaping ((Result<Any?,APIError>)->())) {
        if (self.interactor?.isExchangeRateReady() ?? false) {
            completion(.success(nil))
        } else {
            self.interactor?.fetchExchangeRateFromAPI (completion: { [weak self] (result) in
                guard let `self` = self else { return }
                switch(result){
                case .success(let rate):
                    self.interactor?.saveExchangeRate(exchangeRate: rate)
                    self.interactor?.updateExchangeRateUpdateTime()
                    completion(.success(nil))
                    break
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        }
    }
    
    func getCurrenciesListFromCache() -> [String] {
        return interactor?.loadCurrenciesListFromCache() ?? []
    }
    
    func convertRate(targetCurrency: String) -> String? {
        return interactor?.convertRate(input: entryValue, baseCurrency: selectedCurrency, targetCurrency: targetCurrency)
    }
    
    func getSelectedCurrencyIndex() -> Int {
        return getCurrenciesListFromCache().firstIndex(of: selectedCurrency) ?? 0
    }
    
    func selectCurrencyCandidate(currency:String?) {
        guard let currency = currency else {
            return
        }
        selectedCurrencyCandidate = currency
    }
    
    func replaceCurrencyWithCandidate(){
        guard let selectedCurrencyCandidate = selectedCurrencyCandidate else {
            return
        }
        selectedCurrency = selectedCurrencyCandidate
        self.selectedCurrencyCandidate = nil
        viewController?.refreshExchangeRate()
        viewController?.updateCurrencyDropDownView(currency: selectedCurrency)
    }
    
    func updateEntryValue(decimal: Decimal) {
        entryValue = decimal
        viewController?.refreshExchangeRate()
    }
    
}
