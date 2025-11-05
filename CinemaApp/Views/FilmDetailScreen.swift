//
//  FilmDetailScreen.swift
//  CinemaApp
//
//  Created by Александр Мельников on 04.11.2025.
//

import SwiftUI

struct FilmDetailScreen: View {
    
    let film: Film
    
    var body: some View {
        Text(film.title)
    }
    
}


#Preview {
    FilmDetailScreen(film: Film.example)
}
