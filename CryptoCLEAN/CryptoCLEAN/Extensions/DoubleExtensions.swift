//
//  DoubleExtensions.swift
//  CryptoCLEAN
//
//

import Foundation

extension Double {
    private var currencyFormatter:NumberFormatter {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        return formatter
    }
    
    func toCurrency()-> String {
        currencyFormatter.string(for: self) ?? "$0.00"
    }
    
    func toPercentage()->String {
        String(format: "%.2f", self) + " %"
    }
}
