//
//  GitHubService.swift
//  GitSearch
//
//  Created by Denys Litvinskyi on 14.03.2023.
//

import Foundation

protocol GitHubService {
    func search(for query: String) async throws -> SearchResult
}

final class GitHubServiceProvider: GitHubService {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func search(for query: String) async throws -> SearchResult {
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(query)") else {
            throw "Failed to build URL"
        }

        let request = URLRequest(url: url)
        let (data, response) = try await session.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
          throw "Invalid response"
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(SearchResult.self, from: data)
    }
}

extension String: LocalizedError {
  public var errorDescription: String? {
    return self
  }
}
