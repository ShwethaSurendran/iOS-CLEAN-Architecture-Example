//
//  Crypto.swift
//  CryptoCLEAN
//
//

import Foundation

struct Crypto: Identifiable, Hashable {
    let id: String
    let symbol: String
    let name: String
    let image: URL?
    let currentPrice: Double
    let priceChangePercentage: Double
    let sparkline: [Double]
    let marketCap: Double
    let marketCapPercentage: Double
    let high24h: Double
    let low24h: Double
    let priceChange24h: Double
    let marketCapChange24h: Double
    var isInWatchlist: Bool = false
    
    
    var chartData: [Double] {
        let minValue = sparkline.min() ?? 0
        return sparkline.map { value in
            value - minValue
        }
    }
}
