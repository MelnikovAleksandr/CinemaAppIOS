//
//  FavoriteStorage.swift
//  CinemaApp
//
//  Created by Александр Мельников on 06.11.2025.
//

import Foundation


protocol FavoriteStorage {
    func load() -> Set<String>
    func save(favoritesIDs: Set<String>)
}

struct DefaultFavoriteStorage: FavoriteStorage {
    
    private let favoritesKey = "GhibiExplorer.FavoritesFilms"
    
    func load() -> Set<String> {
        let array = UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
        return Set(array)
    }
    
    func save(favoritesIDs: Set<String>) {
        UserDefaults.standard.set(Array(favoritesIDs), forKey: favoritesKey)
    }
    
}
