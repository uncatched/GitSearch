//
//  Repository.swift
//  GitSearch
//
//  Created by Denys Litvinskyi on 14.03.2023.
//

import Foundation

struct Repository: Decodable, Identifiable {
    let id: Int
    let name: String
    let description: String?
    let owner: Owner
}

extension Repository {
    var avatarURL: URL? {
        URL(string: owner.avatarUrl)
    }
}

extension Repository {
    static var mock: Repository {
        Repository(
            id: 123,
            name: "Tetris",
            description: "A C implementation of Tetris using Pennsim through LC4",
            owner: .mock
        )
    }
}
