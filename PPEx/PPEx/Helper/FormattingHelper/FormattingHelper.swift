//
//  FormattingHelper.swift
//  PPEx
//
//  Created by Ben Leung on 6/12/2020.
//

import Foundation

struct FormattingHelper {
    
    static func formatDecimalToString(decimal: Decimal, decimalPoint: Int) -> String? {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = decimalPoint
        return formatter.string(from: decimal as NSDecimalNumber)
    }
    
}
