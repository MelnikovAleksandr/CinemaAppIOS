//
//  FilmsViewModel.swift
//  CinemaApp
//
//  Created by Александр Мельников on 04.11.2025.
//

import Foundation
import Observation

@MainActor
@Observable
class FilmsViewModel {
    
    var state: LoadingState<[Film]> = .idle
    
    private let service: FilmsService
    
    init(service: FilmsService = FilmsServiceImpl()) {
        self.service = service
    }
    
    func fetch() async {
        guard !state.isLoading || state.error != nil else { return }
        state = .loading
        do {
            let films = try await service.fetchFilms()
            self.state = .loaded(films)
        } catch let error as APIError {
            self.state = .error(error.errorDescription ?? "unknown error")
        } catch {
            self.state = .error("unknown error")
        }
    }
    
    // MARK: - Preview
    static var example: FilmsViewModel {
        let vm = FilmsViewModel(service: MockFilmsService())
        vm.state = .loaded([Film.example, Film.exampleFavorite])
        return vm
    }
    
}
