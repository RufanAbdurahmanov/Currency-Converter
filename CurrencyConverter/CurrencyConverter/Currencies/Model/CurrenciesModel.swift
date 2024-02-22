//
//  CurrenciesModel.swift
//  CurrencyConverter
//
//  Created by Rufan Abdurahmanov on 20.02.24.
//

import Foundation


struct Currency {
    let name: String
    let shortName: String
    var buy: Double
    var sell: Double
    var mb: Double
    let icon: String
}




// MARK: - CurrenciesResponse
struct CurrenciesResponse: Codable {
    let valCurs: ValCurs?

    enum CodingKeys: String, CodingKey {
        case valCurs = "ValCurs"
    }
}

// MARK: - ValCurs
struct ValCurs: Codable {
    let valType: [ValType]?

    enum CodingKeys: String, CodingKey {
        case valType = "ValType"
    }
}

// MARK: - ValType
struct ValType: Codable {
    let valute: [Valute]?

    enum CodingKeys: String, CodingKey {
        case valute = "Valute"
    }
}

// MARK: - Valute
struct Valute: Codable {
    let nominal: Nominal?
    let name: String?
    let value: Double?

    enum CodingKeys: String, CodingKey {
        case nominal = "Nominal"
        case name = "Name"
        case value = "Value"
    }
}
enum Nominal: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Nominal.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Nominal"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
