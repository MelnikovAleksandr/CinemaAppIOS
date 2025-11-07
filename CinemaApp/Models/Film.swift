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
        let bannerURL = URL.convertAssetImage(named: "bannerImage")
        let posterURL = URL.convertAssetImage(named: "posterImage")
        
        return Film(
            id: "2baf70d1",
            title: "Castle in the Sky",
            originalTitle: "天空の城ラピュタ",
            originalTitleRomanised: "Tenkū no shiro Rapyuta",
            image: posterURL?.absoluteString ?? "",
            movieBanner: bannerURL?.absoluteString ?? "",
            description: "The orphan Sheeta inherited a mysterious crystal that links her to the mythical sky-kingdom of Laputa. With the help of resourceful Pazu and a rollicking band of sky pirates, she makes her way to the ruins of the once-great civilization. Sheeta and Pazu must outwit the evil Muska, who plans to use Laputa's science to make himself ruler of the world.",
            director: "Hayao Miyazaki",
            producer: "",
            releaseDate: "1986",
            runningTime: "",
            rtScore: "",
            people: ["https://ghibliapi.vercel.app/people/598f7048-74ff-41e0-92ef-87dc1ad980a9"],
            species: [],
            locations: [],
            vehicles: [],
            url: ""
        )
    }
    
    static var exampleFavorite: Film {
        let bannerURL = URL.convertAssetImage(named: "bannerImage")
        let posterURL = URL.convertAssetImage(named: "posterImage")
        
        return Film(
            id: "2baf70d1-42bb-4437-b551-e5fed5a87abe",
            title: "Castle in the Sky",
            originalTitle: "天空の城ラピュタ",
            originalTitleRomanised: "Tenkū no shiro Rapyuta",
            image: posterURL?.absoluteString ?? "",
            movieBanner: bannerURL?.absoluteString ?? "",
            description: "The orphan Sheeta inherited a mysterious crystal that links her to the mythical sky-kingdom of Laputa. With the help of resourceful Pazu and a rollicking band of sky pirates, she makes her way to the ruins of the once-great civilization. Sheeta and Pazu must outwit the evil Muska, who plans to use Laputa's science to make himself ruler of the world.",
            director: "Hayao Miyazaki",
            producer: "",
            releaseDate: "1986",
            runningTime: "",
            rtScore: "",
            people: ["https://ghibliapi.vercel.app/people/598f7048-74ff-41e0-92ef-87dc1ad980a9"],
            species: [],
            locations: [],
            vehicles: [],
            url: ""
        )
    }
}

