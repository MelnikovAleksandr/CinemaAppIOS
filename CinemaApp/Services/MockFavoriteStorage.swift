//
//  MockFavoriteStorage.swift
//  CinemaApp
//
//  Created by Александр Мельников on 06.11.2025.
//

import Foundation

struct MockFavoriteStorage: FavoriteStorage {
    func load() -> Set<String> {
        ["2baf70d1-42bb-4437-b551-e5fed5a87abe"]
    }
    func save(favoritesIDs: Set<String>) {}
    
}
