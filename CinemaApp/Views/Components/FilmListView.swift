//
//  FilmListView.swift
//  CinemaApp
//
//  Created by Александр Мельников on 04.11.2025.
//

import SwiftUI

struct FilmListView: View {
    var films: [Film]
    var filmsViewModel = FilmsViewModel()
    var body: some View {
        List(films) { film in
            NavigationLink(value: film) {
                HStack {
                    FilmImageView(urlPath: film.image)
                        .frame(width: 100, height: 150)
                    Text(film.title)
                }
            }
        }
        .navigationDestination(for: Film.self) { film in
            FilmDetailScreen(film: film)
        }
    }
}

//#Preview {
//    FilmListView(filmsViewModel: FilmsViewModel(service: MockFilmsService()))
//}
