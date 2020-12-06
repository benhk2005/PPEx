//
//  ConvertHelper.swift
//  PPEx
//
//  Created by Ben Leung on 6/12/2020.
//

import Foundation

struct ConvertHelper {
    
    static func convert(input: Decimal, baseCurrency:String, targetCurrency: String, baseExchangeRate: Decimal, targetExchangeRate: Decimal) -> Decimal {
        if (baseCurrency.compare(targetCurrency) == .orderedSame) {
            return input
        }
        if (baseCurrency.compare(Config.BASE_CURRENCY) == .orderedSame) {
            return input * targetExchangeRate
        }
        return input * (1 / baseExchangeRate) * targetExchangeRate
    }
    
}
