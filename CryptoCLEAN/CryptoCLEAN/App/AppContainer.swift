//
//  AppContainer.swift
//  CryptoCLEAN
//
//

import Foundation

@Observable
final class AppContainer {
    
    private let apiService: CryptosService
    
    private let userDefaultsManager: UserDefaultManagerProtocol
    
    private let repository: CryptoRepository
    
    private let watchlistRepository: WatchlistRepository
    
    private let useCase: CryptoUseCase
    
    init () {
        self.apiService = CryptoServiceImpl()
        self.repository = CryptoRepositoryImpl(service: apiService)
        self.userDefaultsManager = UserDefaultManager()
        self.watchlistRepository = WatchlistRepositoryImpl(userDefaultManager: userDefaultsManager)
        self.useCase = CryptoUseCaseImpl(cryptoRepo: repository, watchlistRepo: watchlistRepository)
    }
    
    func makeCryptosViewModel() -> CryptoViewModel {
        return CryptoViewModel(cryptoUseCase: useCase)
    }
    
}
