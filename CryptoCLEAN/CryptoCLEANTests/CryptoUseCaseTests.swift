//
//  CryptoUseCaseTests.swift
//  CryptoCLEANTests
//
//

@testable import CryptoCLEAN
import XCTest

class CryptoUseCaseTests: XCTestCase {
    
    var useCase: CryptoUseCaseImpl?
    
    func testFetchCryptosSuccess() async {
        useCase = CryptoUseCaseImpl(
            cryptoRepo: CryptoRepoMock(),
            watchlistRepo: WatchlistRepoMock()
        )
        let cryptos = try? await useCase?.fetchCryptos()
        XCTAssertEqual(cryptos?.count, 3)
    }
    
    func testFetchCryptosError() async {
        useCase = CryptoUseCaseImpl(
            cryptoRepo: CryptoRepoMock(shouldThrowError: true),
            watchlistRepo: WatchlistRepoMock()
        )
        do {
            let _ = try await useCase?.fetchCryptos()
            XCTFail("Expect an error to be thrown")
        } catch let error {
            XCTAssertNotNil(error, "")
        }
    }
    
    func testFetchWatchlist() {
        useCase = CryptoUseCaseImpl(
            cryptoRepo: CryptoRepoMock(),
            watchlistRepo: WatchlistRepoMock()
        )
        let watchlists = useCase?.fetchWatchlist() ?? []
        XCTAssertEqual(watchlists.count, 2)
    }
    
    func testSaveWatchlist() {
        let watchlistRepo = WatchlistRepoMock()
        useCase = CryptoUseCaseImpl(
            cryptoRepo: CryptoRepoMock(),
            watchlistRepo: watchlistRepo
        )
        XCTAssertEqual(watchlistRepo.savedWatchlistIds.count, 0)
        useCase?.saveToWatchlist("5")
        XCTAssertEqual(watchlistRepo.savedWatchlistIds.count, 3)
    }
    
    func testRemoveWatchlist() {
        let watchlistRepo = WatchlistRepoMock()
        useCase = CryptoUseCaseImpl(
            cryptoRepo: CryptoRepoMock(),
            watchlistRepo: watchlistRepo
        )
        XCTAssertEqual(watchlistRepo.savedWatchlistIds.count, 0)
        useCase?.removeFromWatchlist("1")
        XCTAssertEqual(watchlistRepo.savedWatchlistIds.count, 1)
    }
    
}

class CryptoRepoMock: CryptoRepository {
    var shouldThrowError: Bool = false
    
    convenience init(shouldThrowError: Bool) {
        self.init()
        self.shouldThrowError = shouldThrowError
    }
    
    func fetchCoins() async throws -> [Crypto] {
        guard !shouldThrowError else {
            throw NSError(domain: "", code: 1)
        }
        return CryptoMockData.sampleCryptos
    }
}

class WatchlistRepoMock: WatchlistRepository {
    
    var savedWatchlistIds: [String] = []
    
    func fetchWatchlist() -> [String] {
        ["1", "2"]
    }
    
    func saveWatchlist(_ watchlistIds: [String]) {
        savedWatchlistIds = watchlistIds
    }
}

