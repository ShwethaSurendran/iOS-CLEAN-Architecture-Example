//
//  CryptoResponse.swift
//  CryptoCLEAN
//
//

import Foundation


struct CryptoResponse: Decodable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let current_price: Double
    let price_change_percentage_24h: Double
    let sparkline_in_7d: sparklineData
    let market_cap: Double
    let market_cap_change_percentage_24h: Double
    let high_24h: Double
    let low_24h: Double
    let price_change_24h: Double
    let market_cap_change_24h: Double
}

struct sparklineData: Decodable {
    let price: [Double]
}

extension CryptoResponse {
    func toCryptoModel() -> Crypto {
        Crypto(
            id: id,
            symbol: symbol,
            name: name,
            image: URL(string: image),
            currentPrice: current_price,
            priceChangePercentage: price_change_percentage_24h,
            sparkline: sparkline_in_7d.price,
            marketCap: market_cap,
            marketCapPercentage: market_cap_change_percentage_24h,
            high24h: high_24h,
            low24h: low_24h,
            priceChange24h: price_change_24h,
            marketCapChange24h: market_cap_change_24h
        )
    }
}
