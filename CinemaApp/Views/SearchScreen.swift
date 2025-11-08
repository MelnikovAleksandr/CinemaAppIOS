//
//  SearchScreen.swift
//  CinemaApp
//
//  Created by Александр Мельников on 05.11.2025.
//

import SwiftUI

struct SearchScreen: View {
    
    @State private var searchViewModel: SearchViewModel
    @State private var text: String = ""
    let favoritesViewModel: FavoritesViewModel
    
    init(favoritesViewModel: FavoritesViewModel, service: FilmsService = FilmsServiceImpl()) {
        self.favoritesViewModel = favoritesViewModel
        self.searchViewModel = SearchViewModel(service: service)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                switch searchViewModel.state {
                case .idle:
                    Text("SearchScreen")
                case .loading:
                    ProgressView()
                case .loaded(let films):
                    FilmListView(films: films, favoritesViewModel: favoritesViewModel)
                case .error(let error):
                    Text(error)
                }
            }
            .searchable(text: $text)
            .task(id: text) {
                await searchViewModel.fetch(for: text)
            }
        }
    }
}

#Preview {
    SearchScreen(favoritesViewModel: FavoritesViewModel(favoritesStorage: MockFavoriteStorage()))
}
