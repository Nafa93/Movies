//
//  SearchOverlay.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 05/09/2024.
//

import SwiftUI

struct SearchOverlay: View {
    @Environment(\.isSearching) private var isSearching
    @State var viewModel: SearchViewModel

    var navigateTo: (_ destination: Destination) -> ()

    var body: some View {
        if isSearching {
            VStack(alignment: .leading, spacing: 24) {
                ForEach(viewModel.results) { result in
                    MovieListItem(
                        title: viewModel.title(for: result),
                        rating: viewModel.rating(for: result),
                        releaseYear: viewModel.releaseYear(for: result),
                        genre: viewModel.genre(for: result),
                        url: viewModel.imageUrl(for: result)
                    )
                    .background(Color.imdbBackground)
                    .onTapGesture {
                        navigateTo(.detail(result))
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.imdbBackground)
            .listStyle(.plain)
            .onChange(of: viewModel.searchQuery) { oldValue, newValue in
                Task {
                    await viewModel.search(newValue)
                }
            }
            .onChange(of: isSearching) { oldValue, newValue in
                viewModel.searchQuery = ""
            }
        }
    }
}
