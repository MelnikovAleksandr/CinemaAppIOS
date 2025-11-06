//
//  FilmImageView.swift
//  CinemaApp
//
//  Created by Александр Мельников on 05.11.2025.
//

import SwiftUI

struct FilmImageView: View {
    
    let url: URL?
    
    init(urlPath: String) {
        self.url = URL(string: urlPath)
    }
    
    init(url: URL?) {
        self.url = url
    }
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                Color(white: 0.8)
                    .overlay {
                        ProgressView().controlSize(.large)
                    }
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure(_):
                Text("No image")
            @unknown default:
                Text("No image")
            }
        }
    }
}


#Preview("poster image") {
    let name = "posterImage"
    let url = URL.convertAssetImage(named: name)
    FilmImageView(url: url)
        .frame(height: 150)
}

#Preview("banner image") {
    let name = "bannerImage"
    let url = URL.convertAssetImage(named: name)
    FilmImageView(url: url)
        .frame(height: 300)
}
