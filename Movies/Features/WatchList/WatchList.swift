//
//  WatchList.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 05/09/2024.
//

import SwiftUI

struct WatchList: View {
    @State var viewModel: WatchListViewModel

    var navigateTo: (_ destination: Destination) -> ()

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                if viewModel.watchList.isEmpty {
                    VStack {
                        ZStack(alignment: .center) {
                            VStack(spacing: 12) {
                                Image("WatchList")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 76, height: 76)

                                Text("There is no movie yet!")
                                    .frame(width: 200)
                                    .multilineTextAlignment(.center)
                                    .font(.regular(16))
                                    .foregroundStyle(.white)

                                Text("Find your movie by Type title, categories, years, etc")
                                    .frame(width: 200)
                                    .multilineTextAlignment(.center)
                                    .font(.regular(12))
                                    .foregroundStyle(.gray)
                            }
                            .frame(minHeight: 600, maxHeight: .infinity)
                        }
                    }
                } else {
                    ForEach(viewModel.watchList) { movie in
                        MovieListItem(
                            title: viewModel.title(for: movie),
                            rating: viewModel.rating(for: movie),
                            releaseYear: viewModel.releaseYear(for: movie),
                            genre: viewModel.genre(for: movie),
                            runtime: viewModel.runtime(for: movie),
                            url: viewModel.imageUrl(for: movie)
                        )
                        .background(Color.imdbBackground)
                        .onTapGesture {
                            navigateTo(.detail(movie))
                        }
                    }
                }
            }
        }
        .task {
            viewModel.getWatchList()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.imdbBackground)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Watch List")
                    .font(.regular(16))
                    .foregroundStyle(Color.white)
            }
        }
    }
}

#Preview {
    NavigationStack {
        WatchList(viewModel: WatchListViewModel(watchListRepository: LocalWatchListRepository()), navigateTo: { _ in })
    }
}
