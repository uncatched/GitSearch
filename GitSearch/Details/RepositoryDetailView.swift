//
//  RepositoryDetailView.swift
//  GitSearch
//
//  Created by Denys Litvinskyi on 14.03.2023.
//

import SwiftUI

struct RepositoryDetailView: View {
    let repository: Repository
    
    var body: some View {
        VStack {
            header
            info


            Spacer()
        }
        .padding(.horizontal)
    }

    private var header: some View {
        HStack {
            AvatarImage(url: repository.avatarURL)

            Text(repository.owner.login)
                .padding(.leading)
                .font(.title)

            Spacer()
        }
    }

    private var info: some View {
        Text(repository.description ?? "")
            .font(.headline)
    }
}

struct RepositoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryDetailView(repository: .mock)
    }
}
