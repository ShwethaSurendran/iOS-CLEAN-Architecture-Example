//
//  CryptoRepository.swift
//  CryptoCLEAN
//
//

protocol CryptoRepository {
    func fetchCoins() async throws -> [Crypto]
}
