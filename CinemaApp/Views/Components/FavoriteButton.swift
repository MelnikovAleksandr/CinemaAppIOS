//
//  FavoriteButton.swift
//  CinemaApp
//
//  Created by Александр Мельников on 06.11.2025.
//

import SwiftUI

struct FavoriteButton: View {
    let filmId: String
    let favoritesViewModel: FavoritesViewModel
    
    private var isFavorite: Bool {
        favoritesViewModel.isFavorite(filmId: filmId)
    }
    
    var body: some View {
        Button {
            favoritesViewModel.toggleFavorite(filmId: filmId)
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart" )
                .foregroundStyle(isFavorite ? Color.pink : Color.gray)
        }
    }
}
