//
//  Double+Extexsion.swift
//  CurrencyConverter
//
//  Created by Rufan Abdurahmanov on 21.02.24.
//

import Foundation


extension Double {
    func removingTrailingZeros() -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 3
        formatter.decimalSeparator = "."
        
        let formattedString = formatter.string(from: NSNumber(value: self)) ?? ""
        return formattedString.replacingOccurrences(of: ",", with: ".")
    }
}
