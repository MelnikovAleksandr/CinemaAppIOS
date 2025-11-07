//
//  FavoritesViewModel.swift
//  CinemaApp
//
//  Created by Александр Мельников on 06.11.2025.
//

import Foundation
import Observation

@Observable
class FavoritesViewModel {
    
    private(set) var favoritesIDs: Set<String> = []
    
    private let favoritesStorage: FavoriteStorage
    
    init(favoritesStorage: FavoriteStorage = DefaultFavoriteStorage()) {
        self.favoritesStorage = favoritesStorage
    }
    
    func load() {
        favoritesIDs = favoritesStorage.load()
    }
    
    private func save() {
        favoritesStorage.save(favoritesIDs: favoritesIDs)
    }
    
    func toggleFavorite(filmId: String) {
        if favoritesIDs.contains(filmId) {
            favoritesIDs.remove(filmId)
        } else {
            favoritesIDs.insert(filmId)
        }
        save()
    }
    
    func isFavorite(filmId: String) -> Bool {
        favoritesIDs.contains(filmId)
    }
    
    //MARK: - preview
        static var example: FavoritesViewModel {
            let vm = FavoritesViewModel(favoritesStorage: MockFavoriteStorage())
            vm.favoritesIDs = ["2baf70d1-42bb-4437-b551-e5fed5a87abe"]
            return vm
        }
    
}
