//
//  FavoritesScreen.swift
//  CinemaApp
//
//  Created by Александр Мельников on 05.11.2025.
//

import SwiftUI

struct FavoritesScreen: View {
    
    let filmsViewModel: FilmsViewModel
    let favoritesViewModel: FavoritesViewModel
    var films: [Film] {
        let favorites = favoritesViewModel.favoritesIDs
        switch filmsViewModel.state {
        case .loaded(let films):
            return films.filter { film in
                favorites.contains(film.id)
            }
        default: return []
        }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if films.isEmpty {
                    ContentUnavailableView(
                        "No Favorites yet",
                        systemImage: "heart"
                    )
                } else {
                    FilmListView(films: films, favoritesViewModel: favoritesViewModel)
                }
            }.navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesScreen(
        filmsViewModel: FilmsViewModel.example,
        favoritesViewModel: FavoritesViewModel.example)
}
