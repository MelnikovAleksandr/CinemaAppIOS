//
//  FilmDetailViewModel.swift
//  CinemaApp
//
//  Created by Александр Мельников on 04.11.2025.
//

import Foundation
import Observation

@MainActor
@Observable
class FilmDetailViewModel {
    
    enum State: Equatable {
        case idle
        case loading
        case loaded([Person])
        case error(String)
    }
    
    var state: State = .idle
    let service: FilmsService
    
    init(service: FilmsService = FilmsServiceImpl()) {
        self.service = service
    }
    
    func fetch(for film: Film) async {
        
        guard state != .loading else { return }
        
        state = .loading
        var loadedPeopleArray: [Person] = []
        do {
            try await withThrowingTaskGroup(of: Person.self) { group in
                for personUrl in film.people {
                    group.addTask {
                        try await self.service.fetchPeople(from: personUrl)
                    }
                }
                for try await person in group {
                    loadedPeopleArray.append(person)
                }
            }
            state = .loaded(loadedPeopleArray)
        } catch let error as APIError {
            self.state = .error(error.errorDescription ?? "unknown error")
        } catch {
            self.state = .error("unknown error")
        }
    }
}
