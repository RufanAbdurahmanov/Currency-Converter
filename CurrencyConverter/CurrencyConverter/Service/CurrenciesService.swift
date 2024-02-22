//
//  CurrenciesService.swift
//  CurrencyConverter
//
//  Created by Rufan Abdurahmanov on 20.02.24.
//

import Foundation


protocol CurrenciesServiceProtocol {
    func fetchCurencies() -> [Currency]
}


class CurrenciesMockService: CurrenciesServiceProtocol {
    
    func fetchCurencies() -> [Currency] {
        return [
            Currency(name: "Azərbaycan Manatı", shortName: "AZN", buy: 1.0, sell: 1.0, mb: 1.0, icon: ""),
            Currency(name: "Amerika dolları", shortName: "USD", buy: 1.696, sell: 1.7025, mb: 1.7, icon: ""),
            Currency(name: "Avro", shortName: "EUR", buy: 1.815, sell: 1.855, mb: 1.8308, icon: ""),
            Currency(name: "Rusiya rublu", shortName: "RUB", buy: 0.0181, sell: 0.0191, mb: 0.0184, icon: ""),
            Currency(name: "Britanya funtu", shortName: "GBP", buy: 2.107, sell: 2.161, mb: 2.1397, icon: ""),
        ]
    }
    
}
