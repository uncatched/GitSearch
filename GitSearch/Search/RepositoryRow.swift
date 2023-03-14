//
//  RepositoryRow.swift
//  GitSearch
//
//  Created by Denys Litvinskyi on 14.03.2023.
//

import SwiftUI

struct RepositoryRow: View {
    let repository: Repository

    var body: some View {
        VStack {
            HStack {
                AvatarImage(url: repository.avatarURL)
                info

                Spacer()
            }

            Divider()
        }
    }

    private var info: some View {
        VStack(alignment: .leading) {
            Text(repository.name)
                .font(.title2)

            if let description = repository.description {
                Text(description)
                    .lineLimit(2)
                    .foregroundColor(.gray)
            }
        }
        .padding(.leading)
    }
}

struct RepositoryRow_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryRow(repository: .mock)
    }
}
