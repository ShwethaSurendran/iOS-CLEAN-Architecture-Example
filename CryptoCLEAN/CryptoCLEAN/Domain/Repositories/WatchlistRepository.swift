//
//  WatchlistRepository.swift
//  CryptoCLEAN
//
//

protocol WatchlistRepository {
    func fetchWatchlist() -> [String]
    func saveWatchlist(_ watchlistIds: [String])
}
