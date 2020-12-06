//
//  CurrenciesViewControllerSpy.swift
//  PPExTests
//
//  Created by Ben Leung on 6/12/2020.
//

import Foundation
@testable import PPEx

class CurrenciesViewControllerSpy: CurrenciesViewInterface {
    var presenter: CurrenciesPresenterInterface?
    
    var setupViewCalled = false
    var showLoadingCalled = false
    var refreshExchangeRateCalled = false
    var updateCurrencyDropDownViewCalled = false
    var updateCurrencyDropDownViewCalledVal: String?
    var showErrorMsgCalled = false
    var showErrorMsgCalledMessage: String?
    var showCurrenciesPickerCalled = false
    
    func showCurrenciesPicker() {
        showCurrenciesPickerCalled = true
    }
    
    func setupView() {
        setupViewCalled = true
    }
    
    func refreshExchangeRate() {
        refreshExchangeRateCalled = true
    }
    
    func showLoading() {
        showLoadingCalled = true
    }
    
    func hideLoading() {
        
    }
    
    func showErrorMsg(message: String) {
        showErrorMsgCalled = true
        showErrorMsgCalledMessage = message
    }
    
    func updateCurrencyDropDownView(currency: String) {
        updateCurrencyDropDownViewCalledVal = currency
        updateCurrencyDropDownViewCalled = true
    }
    
    
    
    
}
