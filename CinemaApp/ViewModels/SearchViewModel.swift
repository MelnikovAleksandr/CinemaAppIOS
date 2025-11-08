//
//  SearchViewModel.swift
//  CinemaApp
//
//  Created by Александр Мельников on 07.11.2025.
//

import Foundation
import Observation

@MainActor
@Observable
class SearchViewModel {
    var state: LoadingState<[Film]> = .idle
    private var currentSearchTerm: String? = nil
    
    private let service: FilmsService
    
    init(service: FilmsService = FilmsServiceImpl()) {
        self.service = service
    }
    
    func fetch(for searchTerm: String) async {
        
        self.currentSearchTerm = searchTerm
        
        guard !searchTerm.isEmpty else {
            state = .idle
            return
        }
        
        state = .loading
        
        try? await Task.sleep(for: .milliseconds(500))
        guard !Task.isCancelled else { return }
        
        do {
            let films = try await service.searchFilms(for: searchTerm)
            self.state = .loaded(films)
        } catch {
            setError(error, for: searchTerm)
        }
    }
    
    func setError(_ error: Error, for searchTerm: String) {
        
        guard currentSearchTerm == searchTerm else { return }
        
        if let error = error as? APIError {
            self.state = .error(error.errorDescription ?? "unknown error")
        } else {
            self.state = .error("unknown error")
        }
        
    }
}
