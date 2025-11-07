//
//  FilmsScreen.swift
//  CinemaApp
//
//  Created by Александр Мельников on 05.11.2025.
//

import SwiftUI

struct FilmsScreen: View {
    
    let filmsViewModel: FilmsViewModel
    let favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                switch filmsViewModel.state {
                case .idle:
                    Text("No films yet")
                case .loading:
                    ProgressView {
                        Text("Loading")
                    }
                case .loaded(let films):
                    FilmListView(films: films, favoritesViewModel: favoritesViewModel)
                case .error(let error):
                    Text(error).foregroundStyle(.pink)
                }
            }.navigationTitle("Ghibli Movies")
        }
    }
}

#Preview {
    FilmsScreen(
        filmsViewModel: FilmsViewModel(service: MockFilmsService()),
        favoritesViewModel: FavoritesViewModel(favoritesStorage: MockFavoriteStorage())
    )
}
