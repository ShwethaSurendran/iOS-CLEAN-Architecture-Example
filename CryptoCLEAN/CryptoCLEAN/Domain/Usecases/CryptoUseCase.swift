//
//  CryptoUseCase.swift
//  CryptoCLEAN
//
//

import Foundation

protocol CryptoUseCase {
    func fetchCryptos() async throws -> [Crypto]
    func saveToWatchlist(_ id: String)
    func removeFromWatchlist(_ id: String)
}


struct CryptoUseCaseImpl: CryptoUseCase {

    let cryptoRepository: CryptoRepository
    let watchlistRepository: WatchlistRepository
    
    init (cryptoRepo: CryptoRepository, watchlistRepo: WatchlistRepository) {
        self.cryptoRepository = cryptoRepo
        self.watchlistRepository = watchlistRepo
    }
    
    func fetchCryptos() async throws -> [Crypto] {
        let cryptos = try await cryptoRepository.fetchCoins()
        let watchlistIds = watchlistRepository.fetchWatchlist()
        return cryptos.map { crypto in
            if watchlistIds.contains(crypto.id) {
                var newCrypto = crypto
                newCrypto.isInWatchlist = true
                return newCrypto
            }

            return crypto
        }
    }
    
    func fetchWatchlist() -> [String] {
        watchlistRepository.fetchWatchlist()
    }
    
    func saveToWatchlist(_ id: String) {
        var watchlistIds = watchlistRepository.fetchWatchlist()
        watchlistIds.append(id)
        watchlistRepository.saveWatchlist(watchlistIds)
    }
    
    func removeFromWatchlist(_ id: String) {
        var watchlistIds = watchlistRepository.fetchWatchlist()
        watchlistIds.removeAll(where: {$0==id})
        watchlistRepository.saveWatchlist(watchlistIds)
    }
    
    
}
