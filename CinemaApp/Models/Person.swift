//
//  Person.swift
//  CinemaApp
//
//  Created by Александр Мельников on 04.11.2025.
//

import Foundation

struct Person: Decodable, Identifiable, Equatable {
    let id: String
    let name: String
    let gender: String
    let age: String
    let eyeColor: String
    let hairColor: String
    let films: [String]
    let species: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case gender = "gender"
        case age = "age"
        case eyeColor = "eye_color"
        case hairColor = "hair_color"
        case films = "films"
        case species = "species"
        case url = "url"
    }
}
