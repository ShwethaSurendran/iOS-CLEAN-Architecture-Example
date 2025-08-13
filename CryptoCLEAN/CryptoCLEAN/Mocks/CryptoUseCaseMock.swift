//
//  File.swift
//  CryptoCLEAN
//
//

import Foundation

struct CryptoMockData {
    static let sampleCryptos: [Crypto] = [
        Crypto(
            id: "1",
            symbol: "BC",
            name: "BitCoin",
            image: URL(string: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400")!,
            currentPrice: 12345,
            priceChangePercentage: 4.5,
            sparkline: [118343.348823438, 118669.277782182, 118653.713346162, 118565.820938645],
            marketCap: 12345,
            marketCapPercentage: 1.38,
            high24h: 3456,
            low24h: 123,
            priceChange24h: 456,
            marketCapChange24h: 789,
            isInWatchlist: true
        ),
        Crypto(
            id: "2",
            symbol: "BC",
            name: "BitCoin",
            image: URL(string: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400")!,
            currentPrice: 12345,
            priceChangePercentage: 0.38,
            sparkline: [118343.348823438, 118669.277782182, 118653.713346162, 118565.820938645],
            marketCap: 12345,
            marketCapPercentage: 1.38,
            high24h: 3456,
            low24h: 123,
            priceChange24h: 456,
            marketCapChange24h: 789),
        Crypto(
            id: "3",
            symbol: "BC",
            name: "BitCoin",
            image: URL(string: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400")!,
            currentPrice: 12345,
            priceChangePercentage: 5.9,
            sparkline: [118343.348823438, 118669.277782182, 118653.713346162, 118565.820938645],
            marketCap: 12345,
            marketCapPercentage: 1.38,
            high24h: 3456,
            low24h: 123,
            priceChange24h: 456,
            marketCapChange24h: 789)
    ]
}

struct CryptoUseCaseMock: CryptoUseCase {
    func saveToWatchlist(_ id: String) {}
    
    func removeFromWatchlist(_ id: String) {}
    
    func fetchCryptos() async throws -> [CryptoCLEAN.Crypto] {
        return CryptoMockData.sampleCryptos
    }
}
