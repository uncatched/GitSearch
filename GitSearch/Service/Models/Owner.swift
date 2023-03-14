//
//  Owner.swift
//  GitSearch
//
//  Created by Denys Litvinskyi on 14.03.2023.
//

import Foundation

struct Owner: Decodable {
    let id: Int
    let avatarUrl: String
    let login: String
}

extension Owner {
    static var mock: Owner {
        Owner(
            id: 123456,
            avatarUrl: "https://secure.gravatar.com/avatar/e7956084e75f239de85d3a31bc172ace?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
            login: "dtrupenn"
        )
    }
}
