//
//  FavoritesScreen.swift
//  CinemaApp
//
//  Created by Александр Мельников on 05.11.2025.
//

import SwiftUI

struct FavoritesScreen: View {
    
    let filmsViewModel: FilmsViewModel
    
    var films: [Film] {
        // TODO
        return []
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
                    FilmListView(films: films)
                }
            }.navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesScreen(
        filmsViewModel: FilmsViewModel(service: MockFilmsService())
    )
}
