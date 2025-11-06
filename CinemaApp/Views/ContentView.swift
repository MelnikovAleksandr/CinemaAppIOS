//
//  ContentView.swift
//  CinemaApp
//
//  Created by Александр Мельников on 05.11.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var filmsViewModel = FilmsViewModel()
    
    var body: some View {
        TabView {
            Tab("Films", systemImage: "movieclapper") {
                FilmsScreen(filmsViewModel: filmsViewModel)
            }
            Tab("Favorites", systemImage: "heart") {
                FavoritesScreen(filmsViewModel: filmsViewModel)
            }
            Tab("Settings", systemImage: "gear") {
                SettingsScreen()
            }
            Tab(role: .search) {
                SearchScreen()
            }
        }
    }
    
}

#Preview {
    ContentView()
}
