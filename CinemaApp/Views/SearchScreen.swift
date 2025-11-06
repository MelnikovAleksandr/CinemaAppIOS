//
//  SearchScreen.swift
//  CinemaApp
//
//  Created by Александр Мельников on 05.11.2025.
//

import SwiftUI

struct SearchScreen: View {
    
    @State private var text: String = ""
    
    var body: some View {
        NavigationStack {
            Text("SearchScreen").searchable(text: $text)
        }
    }
}

#Preview {
    SearchScreen()
}
