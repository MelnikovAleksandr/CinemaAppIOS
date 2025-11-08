//
//  CinemaAppTests.swift
//  CinemaAppTests
//
//  Created by Александр Мельников on 07.11.2025.
//
import Foundation
import Testing
@testable import CinemaApp

struct CinemaAppTests {
    
    @MainActor
    @Test
    func testInitialState() async throws {
        let service = MockFilmsService(mockFilms: mockFilms)
        let viewModel = SearchViewModel(service: service)
        
        #expect(viewModel.state.data == nil)
        
        if case .idle = viewModel.state {
            
        } else {
            Issue.record("Expected idle state")
        }
    }
    
    @MainActor
    @Test
    func testSearchWithQuery() async {
        let service = MockFilmsService(mockFilms: mockFilms)
        let viewModel = SearchViewModel(service: service)
        
        await viewModel.fetch(for: "Totoro")
        
        #expect(viewModel.state.data?.count == 1)
        #expect(viewModel.state.data?.first?.title == "My Neighbor Totoro")
    }
    
    @MainActor
    @Test
    func testSearchWithError() async {
        let service = MockFilmsService(mockFilms: mockFilms, shouldThrowError: true)
        let viewModel = SearchViewModel(service: service)
        
        await viewModel.fetch(for: "Totoro")
        #expect(viewModel.state.error != nil)
        
    }
    
    @MainActor
    @Test
    func testCancellationAfterApiCall() async throws {
        let service = MockFilmsService(mockFilms: mockFilms, fetchDelay: .milliseconds(100))
        let viewModel = SearchViewModel(service: service)
        
        let task = Task {
            await viewModel.fetch(for: "tot")
        }
        try? await Task.sleep(for: .milliseconds(550))
        task.cancel()
        await task.value
        let fetchCallCount = await service.fetchCallCount
        #expect(fetchCallCount == 1)
        let lastSearchQuery = await service.lastSearchQuery
        #expect(lastSearchQuery == "tot")
        #expect(viewModel.state.error != nil)
    }
    
    @MainActor
    @Test
    func testDebounceWithMultipleSearches() async {
        let service = MockFilmsService(mockFilms: mockFilms)
        
        let viewModel = SearchViewModel(service: service)
        
        let searchQueries = ["t", "to", "tot", "toto", "totor", "totoro"]
        var tasks: [Task<Void, Never>] = []
        
        for query in searchQueries {
            tasks.last?.cancel()
            
            let task = Task {
                await viewModel.fetch(for: query)
            }
            tasks.append(task)
            
            try? await Task.sleep(for: .milliseconds(50))
        }
        
        await tasks.last?.value
        
        let callCount = await service.fetchCallCount
        let lastQuery = await service.lastSearchQuery
        
        #expect(callCount == 1, "Only the final search should execute")
        #expect(lastQuery == "totoro", "Should search for the final query")
        #expect(viewModel.state.data?.count == 1)
        #expect(viewModel.state.data?.first?.title == "My Neighbor Totoro")
    }
    
    @MainActor
    @Test
    func testDebounceWithSlowMultipleSearches() async {
        let service = MockFilmsService(mockFilms: mockFilms)
        
        let viewModel = SearchViewModel(service: service)
        
        let searchQueries = ["tot", "totor", "totoro"]
        var tasks: [Task<Void, Never>] = []
        
        for query in searchQueries {
            tasks.last?.cancel()
            
            let task = Task {
                await viewModel.fetch(for: query)
            }
            tasks.append(task)
            
            try? await Task.sleep(for: .milliseconds(550))
        }
        
        await tasks.last?.value
        
        let callCount = await service.fetchCallCount
        let lastQuery = await service.lastSearchQuery
        
        #expect(callCount == 3, "all searchs should execute")
        #expect(lastQuery == "totoro", "Should search for the final query")
        #expect(viewModel.state.data?.count == 1)
        #expect(viewModel.state.data?.first?.title == "My Neighbor Totoro")
    }
    
    actor MockFilmsService: FilmsService {
        
        let mockFilms: [Film]
        let shouldThrowError: Bool
        let fetchDelay: Duration
        
        var fetchCallCount = 0
        var lastSearchQuery: String? = nil
        
        init(mockFilms: [Film],
             shouldThrowError: Bool = false,
             fetchDelay: Duration = .zero) {
            self.mockFilms = mockFilms
            self.shouldThrowError = shouldThrowError
            self.fetchDelay = fetchDelay
        }
        
        func fetchFilms() async throws -> [Film] {
            if shouldThrowError {
                throw APIError.networkError(NSError(domain: "Test", code: -1))
            }
            
            if fetchDelay > .zero {
                try? await Task.sleep(for: fetchDelay)
            }
            
            return mockFilms
        }
        
        func searchFilms(for searchTerm: String) async throws -> [Film] {
            
            self.fetchCallCount += 1
            self.lastSearchQuery = searchTerm
            
            if shouldThrowError {
                throw APIError.networkError(NSError(domain: "Test", code: -1))
            }
            
            if fetchDelay > .zero {
                try? await Task.sleep(for: fetchDelay)
            }
            
            try Task.checkCancellation()
            
            if searchTerm.isEmpty {
                return mockFilms
            }
            
            return mockFilms.filter {
                $0.title.localizedCaseInsensitiveContains(searchTerm)
            }
        }
        
        func fetchPeople(from URLString: String) async throws -> Person {
            return Person(id: "", name: "", gender: "", age: "", eyeColor: "", hairColor: "", films: [], species: "", url: "")
        }
        
    }
    
    // MARK: - Test Data
    let mockFilms = [
        Film(
            id: "1",
            title: "My Neighbor Totoro",
            originalTitle: "",
            originalTitleRomanised: "",
            image: "",
            movieBanner: "",
            description: "Two sisters discover Totoro",
            director: "Hayao Miyazaki",
            producer: "Isao Takahata",
            releaseDate: "1988",
            runningTime: "",
            rtScore: "93",
            people: [],
            species: [],
            locations: [],
            vehicles: [],
            url: ""
        ),
        Film(
            id: "2",
            title: "Spirited Away",
            originalTitle: "",
            originalTitleRomanised: "",
            image: "",
            movieBanner: "",
            description: "A girl enters a spirit world",
            director: "Hayao Miyazaki",
            producer: "Toshio Suzuki",
            releaseDate: "2001",
            runningTime: "",
            rtScore: "97",
            people: [],
            species: [],
            locations: [],
            vehicles: [],
            url: ""
        ),
        Film(
            id: "3",
            title: "Princess Mononoke",
            originalTitle: "",
            originalTitleRomanised: "",
            image: "",
            movieBanner: "",
            description: "A prince fights to save the forest",
            director: "Hayao Miyazaki",
            producer: "Toshio Suzuki",
            releaseDate: "1997",
            runningTime: "",
            rtScore: "92",
            people: [],
            species: [],
            locations: [],
            vehicles: [],
            url: ""
        )
    ]
    
}
