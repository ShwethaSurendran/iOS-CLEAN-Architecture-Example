//
//  WatchlistRepositoryImpl.swift
//  CryptoCLEAN
//
//

import Foundation


struct WatchlistRepositoryImpl: WatchlistRepository {
    
    let userDefaultManager: UserDefaultManagerProtocol
    
    init(userDefaultManager: UserDefaultManagerProtocol) {
        self.userDefaultManager = userDefaultManager
    }
    
    func fetchWatchlist() -> [String] {
        userDefaultManager.getFromUserDefaults(key: UserDefaultsKeys.watchlist) as? [String] ?? []
    }
    
    func saveWatchlist(_ watchlistIds: [String]) {
        userDefaultManager.saveToUserDefaults(key: UserDefaultsKeys.watchlist, value: watchlistIds)
    }
}
