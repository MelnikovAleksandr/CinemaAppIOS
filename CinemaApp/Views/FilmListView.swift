//
//  FilmListView.swift
//  CinemaApp
//
//  Created by Александр Мельников on 04.11.2025.
//

import SwiftUI

struct FilmListView: View {
    
    var filmsViewModel = FilmsViewModel()
    var body: some View {
        NavigationStack {
            switch filmsViewModel.state {
            case .idle:
                Text("No films yet")
            case .loading:
                ProgressView {
                    Text("Loading")
                }
            case .loaded(let films):
                List(films) { film in
                    NavigationLink(value: film) {
                        Text(film.title)
                    }
                }
                .navigationDestination(for: Film.self) { film in
                    FilmDetailScreen(film: film)
                }
            case .error(let error):
                Text(error).foregroundStyle(.pink)
            }
        }.task {
            await filmsViewModel.fetch()
        }
    }
}

#Preview {
    FilmListView(filmsViewModel: FilmsViewModel(service: MockFilmsService()))
}
