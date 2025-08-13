//
//  CryptoViewModelTests.swift
//  CryptoCLEANTests
//
//

@testable import CryptoCLEAN
import XCTest

class CryptoViewModelTests: XCTestCase {
    
    var viewModel: CryptoViewModel?
    
    func testFetchCryptosSuccess() async {
        viewModel = CryptoViewModel(cryptoUseCase: CryptoUseCaseMock())
        await viewModel?.fetchCryptos()
        
        guard case .complete(_) = viewModel?.loadingState else {
            XCTFail("Loading state should be complete")
            return
        }
        
        XCTAssertEqual(viewModel?.cryptos.count, 3)
    }
    
    func testFetchCryptosError() async {
        let newViewModel = CryptoViewModel(cryptoUseCase: CryptoUseCaseMock(shouldThrowError: true))
        await newViewModel.fetchCryptos()
        guard case .error(_) = newViewModel.loadingState else {
            XCTFail("Loading state should be complete")
            return
        }
        XCTAssertEqual(newViewModel.cryptos.count, 0)
    }
    
    func testTopPerformers() async {
        viewModel = CryptoViewModel(cryptoUseCase: CryptoUseCaseMock())
        await viewModel?.fetchCryptos()
        let topPerformers = viewModel?.getTopPerformers() ?? []
        XCTAssertEqual(topPerformers.count, 3)
        XCTAssertTrue(((topPerformers.first?.id) != nil), "3")
    }
    
    func testTotal() async {
        viewModel = CryptoViewModel(cryptoUseCase: CryptoUseCaseMock())
        await viewModel?.fetchCryptos()
        let total = viewModel?.getTotal(quantity: "4", crypto: (viewModel?.cryptos.first)!)
        XCTAssertEqual(total, 49380)
    }
    
    func testWatchlists() async {
        viewModel = CryptoViewModel(cryptoUseCase: CryptoUseCaseMock())
        await viewModel?.fetchCryptos()
        let watchlists = viewModel?.getWatchlist()
        XCTAssertEqual(watchlists?.count, 1)
        XCTAssertEqual(watchlists?.first?.id, "1")
    }
    
    func testToggleWatchlist() async {
        viewModel = CryptoViewModel(cryptoUseCase: CryptoUseCaseMock())
        await viewModel?.fetchCryptos()
        XCTAssertTrue(viewModel?.cryptos.first?.isInWatchlist ?? false)
        viewModel?.toggleWatchlist((viewModel?.cryptos.first)!)
        XCTAssertFalse(viewModel?.cryptos.first?.isInWatchlist ?? false)
    }
    
    func testSaveWatchlist() async {
        let mockUseCase = CryptoUseCaseMock()
        viewModel = CryptoViewModel(cryptoUseCase: mockUseCase)
        await viewModel?.fetchCryptos()
        XCTAssertEqual(mockUseCase.savedWatchlistId, "")
        XCTAssertFalse(viewModel?.cryptos[1].isInWatchlist ?? false)
        viewModel?.toggleWatchlist((viewModel?.cryptos[1])!)
        XCTAssertTrue(viewModel?.cryptos[1].isInWatchlist ?? false)
        XCTAssertEqual(mockUseCase.savedWatchlistId, "2")
    }
    
    func testRemoveWatchlist() async {
        let mockUseCase = CryptoUseCaseMock()
        viewModel = CryptoViewModel(cryptoUseCase: mockUseCase)
        await viewModel?.fetchCryptos()
        XCTAssertEqual(mockUseCase.removedWatchlistId, "")
        XCTAssertTrue(viewModel?.cryptos.first?.isInWatchlist ?? false)
        viewModel?.toggleWatchlist((viewModel?.cryptos.first)!)
        XCTAssertFalse(viewModel?.cryptos.first?.isInWatchlist ?? false)
        XCTAssertEqual(mockUseCase.removedWatchlistId, "1")
    }
    
}


class CryptoUseCaseMock: CryptoUseCase {
    
    var shouldThrowError: Bool = false
    var savedWatchlistId: String = ""
    var removedWatchlistId: String = ""
    
    convenience init(shouldThrowError: Bool) {
        self.init()
        self.shouldThrowError = shouldThrowError
    }
    
    func saveToWatchlist(_ id: String) {
        savedWatchlistId = id
    }
    
    func removeFromWatchlist(_ id: String) {
        removedWatchlistId = id
    }
    
    func fetchCryptos() async throws -> [CryptoCLEAN.Crypto] {
        guard !shouldThrowError else {
            throw NSError()
        }
        return CryptoMockData.sampleCryptos
    }
}
