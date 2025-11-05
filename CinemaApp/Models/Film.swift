//
//  Film.swift
//  CinemaApp
//
//  Created by Александр Мельников on 04.11.2025.
//

import Foundation

struct Film: Codable, Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let originalTitle: String
    let originalTitleRomanised: String
    let image: String
    let movieBanner: String
    let description: String
    let director: String
    let producer: String
    let releaseDate: String
    let runningTime: String
    let rtScore: String
    let people: [String]
    let species: [String]
    let locations: [String]
    let vehicles: [String]
    let url: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case originalTitle = "original_title"
        case originalTitleRomanised = "original_title_romanised"
        case image = "image"
        case movieBanner = "movie_banner"
        case description = "description"
        case director = "director"
        case producer = "producer"
        case releaseDate = "release_date"
        case runningTime = "running_time"
        case rtScore = "rt_score"
        case people = "people"
        case species = "species"
        case locations = "locations"
        case vehicles = "vehicles"
        case url = "url"
    }
    
    static var example: Film {
        MockFilmsService().fetchFilm()
    }
}

