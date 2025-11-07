//
//  FilmListView.swift
//  CinemaApp
//
//  Created by Александр Мельников on 04.11.2025.
//

import SwiftUI

struct FilmListView: View {
    var films: [Film]
    let favoritesViewModel: FavoritesViewModel
    var body: some View {
        List(films) { film in
            NavigationLink(value: film) {
                FilmRow(film: film, favoritesViewModel: favoritesViewModel)
            }
        }
        .navigationDestination(for: Film.self) { film in
            FilmDetailScreen(film: film, favoritesViewModel: favoritesViewModel)
        }
    }
}

private struct FilmRow: View {
    let film: Film
    let favoritesViewModel: FavoritesViewModel
    var body: some View {
        HStack(alignment: .top) {
            FilmImageView(urlPath: film.image)
                .frame(width: 100, height: 150)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(film.title).bold()
                    Spacer()
                    FavoriteButton(filmId: film.id, favoritesViewModel: favoritesViewModel)
                        .buttonStyle(.plain)
                        .controlSize(.large)
                }
                .padding(.bottom, 5)
                
                
                Text("Directed by \(film.director)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text("Released:  \(film.releaseDate)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }.padding(.top)
            
        }
    }
}

#Preview {
    
    @State @Previewable var favoritesViewModel = FavoritesViewModel(favoritesStorage: MockFavoriteStorage())
    NavigationStack {
        FilmListView(films: [Film.exampleFavorite] + [Film.example], favoritesViewModel: favoritesViewModel)
    }
    .task {
        favoritesViewModel.load()
    }
}
