//
//  CurrenciesViewModel.swift
//  CurrencyConverter
//
//  Created by Rufan Abdurahmanov on 20.02.24.
//

import Foundation
import UIKit

protocol CurrenciesViewModelProtocol {
    var view: CurrenciesViewProtocol? { get }
    func viewDidLoad()
}


class CurrenciesViewModel {
    
    weak var view: CurrenciesViewProtocol?
    
    private var service: CurrenciesServiceProtocol
    
    init(service: CurrenciesServiceProtocol) {
        self.service = service
    }
    
    var currencies: [Currency] = []
    
    func getCurrencies(complete: (()->Void) ) {
        self.currencies = service.fetchCurencies()
        complete()
    }
    
    func numberOFRows() -> Int {
        return currencies.count
    }
    
    func itemAtRow(index: Int) -> Currency {
        return currencies[index]
    }
    
}

extension CurrenciesViewModel: CurrenciesViewModelProtocol {
    
    func viewDidLoad() {
        guard let view = view else { return }
        view.setupLayouts()
        view.getCurrencies()
    }
    
    
}

