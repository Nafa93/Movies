//
//  HomeView.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 03/09/2024.
//

import SwiftUI

struct HomeView: View {
    @State var viewModel: HomeViewModel
    @State var searchViewModel: SearchViewModel

    var navigateTo: (_ destination: Destination) -> ()

    var body: some View {
        ScrollView(.vertical) {
            if !searchViewModel.searchQuery.isEmpty {
                SearchOverlay(viewModel: searchViewModel, navigateTo: navigateTo)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                LazyVStack(spacing: 20) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        MovieHorizontalList(movies: $viewModel.popular,
                                            imageUrl: viewModel.imageUrl(for:),
                                            onItemTapped: {
                            movie in navigateTo(.detail(movie))
                        })
                    }
                    .contentMargins(32, for: .scrollContent)

                    SegmentedView(selected: $viewModel.selectedCategory, segments: Segment.homeSegments)
                        .padding(.horizontal, 24)

                    switch viewModel.selectedCategory {
                    case .nowPlaying:
                        MovieGrid(columnSize: 3, movies: viewModel.nowPlaying, imageUrl: viewModel.imageUrl(for:), onItemTapped: { movie in
                            navigateTo(.detail(movie))
                        })
                        .padding(.horizontal, 24)
                    case .upcoming:
                        MovieGrid(columnSize: 3, movies: viewModel.upcoming, imageUrl: viewModel.imageUrl(for:), onItemTapped: { movie in
                            navigateTo(.detail(movie))
                        })
                        .padding(.horizontal, 24)
                    case .topRated:
                        MovieGrid(columnSize: 3, movies: viewModel.topRated, imageUrl: viewModel.imageUrl(for:), onItemTapped: { movie in
                            navigateTo(.detail(movie))
                        })
                        .padding(.horizontal, 24)
                    default:
                        EmptyView()
                    }
                }
                .padding(.vertical, 24)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("What do you want to watch?")
                    .font(.semiBold(18))
                    .foregroundStyle(Color.white)
            }
        }
        .searchable(
            text: $searchViewModel.searchQuery,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search"
        )
        .task {
            await viewModel.getPopular()
            await viewModel.getNowPlaying()
            await viewModel.getTopRated()
            await viewModel.getUpcoming()
        }
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.imdbBackground)
    }
}

#Preview {
    NavigationStack {
        HomeView(
            viewModel: HomeViewModel(
                repository: LocalMovieRepository()
            ), 
            searchViewModel: SearchViewModel(),
            navigateTo: { _ in }
        )
    }
}
