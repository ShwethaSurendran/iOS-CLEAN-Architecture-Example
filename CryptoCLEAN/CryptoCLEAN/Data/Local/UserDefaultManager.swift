//
//  UserDefaultManager.swift
//  CryptoCLEAN
//
//

import Foundation

enum UserDefaultsKeys: String {
    case watchlist = "watchlist_ids"
}

protocol UserDefaultManagerProtocol {
    func saveToUserDefaults(key: UserDefaultsKeys, value: Any?)
    func getFromUserDefaults(key: UserDefaultsKeys) -> Any?
}

struct UserDefaultManager: UserDefaultManagerProtocol {
    
    func saveToUserDefaults(key: UserDefaultsKeys, value: Any?) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func getFromUserDefaults(key: UserDefaultsKeys) -> Any? {
        return UserDefaults.standard.object(forKey: key.rawValue)
    }
}
