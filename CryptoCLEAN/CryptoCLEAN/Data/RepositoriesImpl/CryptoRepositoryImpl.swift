//
//  CryptoRepository.swift
//  CryptoCLEAN
//
//

import Foundation

struct CryptoRepositoryImpl: CryptoRepository {
    
    var service: CryptosService
    
    init (service: CryptosService) {
        self.service = service
    }
    
    func fetchCoins() async throws -> [Crypto] {
        let responseData = try await service.getCryptos()
        let mapped = responseData.map {$0.toCryptoModel()}
        return mapped
    }
}



