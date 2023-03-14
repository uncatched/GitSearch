//
//  SearchListViewModel.swift
//  GitSearch
//
//  Created by Denys Litvinskyi on 14.03.2023.
//

import Foundation
import Combine

final class SearchListViewModel: ObservableObject {
    @Published var searchQuery = ""
    @Published var isLoading = false //TODO: change to State
    @Published var error: String?

    @Published private(set) var repositories: [Repository] = []

    private let service: GitHubService
    private var cancellables = Set<AnyCancellable>()

    init(service: GitHubService = GitHubServiceProvider()) {
        self.service = service

        listenSearchQuery()
    }

    private func listenSearchQuery() {
        $searchQuery
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] query in
                self?.search(for: query)
            }
            .store(in: &cancellables)
    }

    private func search(for query: String) {
        guard !query.isEmpty else {
            repositories.removeAll()
            return
        }

        Task {
            await load(query: query)
        }
    }

    @MainActor
    private func load(query: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let result = try await service.search(for: query)
            repositories = result.items
        } catch {
            self.error = error.localizedDescription
        }
    }
}
