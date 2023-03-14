//
//  SearchListView.swift
//  GitSearch
//
//  Created by Denys Litvinskyi on 14.03.2023.
//

import SwiftUI

struct SearchListView: View {
    @StateObject private var viewModel = SearchListViewModel()

    var body: some View {
        NavigationView {
            content
                .navigationTitle("Search for repo")
                .navigationBarTitleDisplayMode(.large)
        }
        .searchable(text: $viewModel.searchQuery)
    }

    @ViewBuilder
    private var content: some View {
        if let error = viewModel.error {
            VStack {
                Spacer()
                Text(error)
                    .font(.largeTitle)
                    .foregroundColor(.red)
                Spacer()
            }
        } else {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.repositories) { repository in
                        NavigationLink {
                            RepositoryDetailView(repository: repository)
                        } label: {
                            RepositoryRow(repository: repository)
                        }
                    }
                    .padding(.horizontal)
                }

                ProgressView()
                    .opacity(viewModel.isLoading ? 1 : 0)
            }
        }
    }
}

struct SearchListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchListView()
    }
}
