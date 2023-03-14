//
//  SearchResult.swift
//  GitSearch
//
//  Created by Denys Litvinskyi on 14.03.2023.
//

import Foundation

struct SearchResult: Decodable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Repository]
}
