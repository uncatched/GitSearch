//
//  SearchListViewModelTests.swift
//  GitSearchTests
//
//  Created by Denys Litvinskyi on 14.03.2023.
//

import XCTest
import Combine

@testable import GitSearch

extension SearchResult {
    static var mock: SearchResult {
        SearchResult(
            totalCount: 40,
            incompleteResults: false,
            items: [.mock]
        )
    }
}

final class SearchListViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()

    func testSearchResultReceived() {
        final class GitHubServiceMocked: GitHubService {
            func search(for query: String) async throws -> SearchResult {
                .mock
            }
        }

        let service = GitHubServiceMocked()
        let viewModel = SearchListViewModel(service: service)

        XCTAssertTrue(viewModel.repositories.isEmpty)

        let expectation = expectation(description: "Repositories expectation")
        viewModel
            .$repositories
            .dropFirst()
            .sink { repositories in
                XCTAssertEqual(repositories.count, 1)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.searchQuery = "123"

        waitForExpectations(timeout: 1)
    }

    func testErrorReceived() {
        final class GitHubServiceMocked: GitHubService {
            func search(for query: String) async throws -> SearchResult {
                throw "Error."
            }
        }

        let service = GitHubServiceMocked()
        let viewModel = SearchListViewModel(service: service)

        XCTAssertTrue(viewModel.repositories.isEmpty)

        let expectation = expectation(description: "Repositories expectation")
        viewModel
            .$error
            .dropFirst()
            .sink { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.searchQuery = "123"

        waitForExpectations(timeout: 1)
    }
}
