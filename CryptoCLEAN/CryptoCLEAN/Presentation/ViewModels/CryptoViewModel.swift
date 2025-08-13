//
//  CryptoViewModel.swift
//  CryptoCLEAN
//
//

import Foundation

enum ContentLoadingState {
    case loading
    case complete([Crypto])
    case error(Error)
}

@Observable
class CryptoViewModel {
    
    let cryptoUseCase: CryptoUseCase
    var cryptos: [Crypto] = []
    var loadingState: ContentLoadingState = .loading
    
    init(cryptoUseCase: CryptoUseCase) {
        self.cryptoUseCase = cryptoUseCase
        
        Task {
            await fetchCryptos()
        }
    }
    
    func fetchCryptos() async {
        do {
            loadingState = .loading
            cryptos = try await cryptoUseCase.fetchCryptos()
            let sortedCryptos = cryptos.sorted { $0.name < $1.name }
            loadingState = .complete(sortedCryptos)
        } catch  {
            loadingState = .error(error)
        }
    }
    
    func getTopPerformers() -> [Crypto] {
        Array(cryptos
            .sorted { $0.priceChangePercentage > $1.priceChangePercentage }
                .prefix(10)
              )
    }
    
    func getTotal(quantity: String, crypto: Crypto)-> Double {
       (Double(quantity) ?? 0) * crypto.currentPrice
    }
    
    func getWatchlist() -> [Crypto] {
        cryptos.filter({$0.isInWatchlist})
    }
    
    func toggleWatchlist(_ crypto: Crypto) {
        guard let indexOfItem = (cryptos.firstIndex { $0.id == crypto.id }) else {return}
        
        if cryptos[indexOfItem].isInWatchlist {
            cryptoUseCase.removeFromWatchlist(crypto.id)
        }else {
            cryptoUseCase.saveToWatchlist(crypto.id)
        }
        cryptos[indexOfItem].isInWatchlist.toggle()
    }
    
}
