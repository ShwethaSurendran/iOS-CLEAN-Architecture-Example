//
//  CryptoRepoTests.swift
//  CryptoCLEANTests
//
//

@testable import CryptoCLEAN
import XCTest

class CryptoRepoTests: XCTestCase {
    
    func testFetchCoinsSuccess() async throws {
        let repo = CryptoRepositoryImpl(service: CryptosServiceMock())
        let cryptos = try await repo.fetchCoins()
        XCTAssertEqual(cryptos.count, 2)
        XCTAssertEqual(cryptos[0].id, "123")
    }
    
    func testFetchCoinsFailure() async throws {
        let repo = CryptoRepositoryImpl(service: CryptosServiceMock(shouldThrowError: true))
        do {
            let _ = try await repo.fetchCoins()
            XCTFail("Expect an error to be thrown")
        } catch let error {
            XCTAssertNotNil(error, "")
        }
    }
    
}


class CryptosServiceMock: CryptosService {
    
    var shouldThrowError: Bool = false
    
    let cryptoMockResponse: [CryptoResponse] = [
        .init(id: "123", symbol: "abc", name: "", image: "", current_price: 123, price_change_percentage_24h: 123, sparkline_in_7d: .init(price: [123]), market_cap: 123, market_cap_change_percentage_24h: 123, high_24h: 123, low_24h: 123, price_change_24h: 123, market_cap_change_24h: 123),
        .init(id: "234", symbol: "abc", name: "", image: "", current_price: 123, price_change_percentage_24h: 123, sparkline_in_7d: .init(price: [123]), market_cap: 123, market_cap_change_percentage_24h: 123, high_24h: 123, low_24h: 123, price_change_24h: 123, market_cap_change_24h: 123)
    ]
    
    convenience init(shouldThrowError: Bool = false) {
        self.init()
        self.shouldThrowError = shouldThrowError
    }
    
    func getCryptos() async throws -> [CryptoResponse] {
        guard !shouldThrowError else {
            throw NSError(domain: "", code: 1)
        }
        return cryptoMockResponse
    }
}

