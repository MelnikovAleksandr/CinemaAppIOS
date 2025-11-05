//
//  APIError.swift
//  CinemaApp
//
//  Created by Александр Мельников on 04.11.2025.
//
import Foundation

enum APIError: LocalizedError {
    case invalideURL
    case invalidResponse
    case decoding(Error)
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalideURL:
            return "The Url is invalide"
        case .invalidResponse:
            return "Invalide response from server"
        case .decoding(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}
