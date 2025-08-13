//
//  CryptosService.swift
//  CryptoCLEAN
//
//

import Foundation


protocol CryptosService {
    func getCryptos() async throws -> [CryptoResponse]
}

struct CryptoServiceImpl: CryptosService {
    func getCryptos() async throws -> [CryptoResponse] {
        guard let url = URL(string: AppConfig.baseURL+Endpoints.cryptos) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode([CryptoResponse].self, from: data)
        return decodedResponse
    }
}
