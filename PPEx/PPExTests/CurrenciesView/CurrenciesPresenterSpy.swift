//
//  CurrenciesPresenterSpy.swift
//  PPExTests
//
//  Created by Ben Leung on 6/12/2020.
//

import XCTest
@testable import PPEx

class CurrenciesPresenterSpy : CurrenciesPresenterInterface {
    
    var interactor: CurrenciesInteractorInterface?
    
    var viewController: CurrenciesViewInterface?
    
    var currenciesListIsReadyValue: Bool = false
    var gridSizeValue:CGSize = CGSize.zero
    var currenciesListFromCache = [String]()
    
    var viewIsReadyCalled: Bool = false
    var currenciesListIsReadyCalled: Bool = false
    var calculateGridSizeCalled: Bool = false
    var loadCurrenciesListCalled: Bool = false
    var convertRateCalled:Bool = false
    var getSelectedCurrencyIndexCalled = false
    var selectCurrencyCandidateCalled = false
    var replaceCurrencyWithCandidateCalled = false
    var updateEntryValueCalled = false
    var currentDropDownViewDidClickCalled = false
    var numOfColumnsCalledVal = 0
    var updateEntryDecimalValue:Decimal?
    
    func viewIsReady() {
        viewIsReadyCalled = true
    }
    
    func currenciesListIsReady() -> Bool {
        currenciesListIsReadyCalled = true
        return currenciesListIsReadyValue
    }
    
    func calculateGridSize(numOfColumns: Int) -> CGSize {
        numOfColumnsCalledVal = numOfColumns
        calculateGridSizeCalled = true
        return gridSizeValue
    }
    
    func loadCurrenciesList(completion: @escaping ((Result<[String], APIError>) -> Void)) {
        loadCurrenciesListCalled = true
    }
    
    func currentDropDownViewDidClick() {
        currentDropDownViewDidClickCalled = true
    }
    
    func getCurrenciesListFromCache() -> [String] {
        return currenciesListFromCache
    }
    
    func convertRate(targetCurrency: String) -> String? {
        convertRateCalled = true
        return nil
    }
    
    func getSelectedCurrencyIndex() -> Int {
        getSelectedCurrencyIndexCalled = true
        return 0
    }
    
    func selectCurrencyCandidate(currency: String?) {
        selectCurrencyCandidateCalled = true
    }
    
    func replaceCurrencyWithCandidate() {
        replaceCurrencyWithCandidateCalled = true
    }
    
    func updateEntryValue(decimal: Decimal) {
        updateEntryValueCalled = true
        updateEntryDecimalValue = decimal
    }
    
    
}
