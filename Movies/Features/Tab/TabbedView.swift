//
//  TabbedView.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 04/09/2024.
//

import SwiftUI

enum Destination: Hashable {
    case detail(_ movie: Movie)

    func hash(into hasher: inout Hasher) {
        hasher.combine(self)
    }
}

@Observable class TabbedViewModel {
    var tabs: [Tab] = Tab.allCases
    var selectedTab: Tab = .home
    var homeViewModel = HomeViewModel(repository: IMDBMovieRepository())
    var searchViewModel = SearchViewModel()
    var watchListRepository = JSONWatchListRespository()
    var watchListViewModel: WatchListViewModel {
        WatchListViewModel(watchListRepository: watchListRepository)
    }

    var homeTabPath: [Destination] = []
    var searchTabPath: [Destination] = []
    var watchListTabPath: [Destination] = []
}

struct TabbedView: View {
    @State var viewModel: TabbedViewModel
    
    init(viewModel: TabbedViewModel) {
        self.viewModel = viewModel

        setupTabBarAppearance()

        setupNavBarAppearance()
    }

    var body: some View {
        TabView(selection: $viewModel.selectedTab) {

            NavigationStack(path: $viewModel.homeTabPath) {
                HomeView(
                    viewModel: viewModel.homeViewModel, 
                    searchViewModel: SearchViewModel(),
                    navigateTo: { destination in viewModel.homeTabPath.append(destination) }
                )
                .navigationDestination(for: Destination.self) { destination in
                    switch destination {
                    case .detail(let movie):
                        DetailView(
                            viewModel: DetailViewModel(
                                movie: movie,
                                movieRepository: IMDBMovieRepository(),
                                watchListRepository: viewModel.watchListRepository
                            )
                        )
                    }
                }
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            .tint(.white)

            NavigationStack(path: $viewModel.searchTabPath) {
                Search(
                    viewModel: viewModel.searchViewModel,
                    navigateTo: { destination in viewModel.searchTabPath.append(destination) }
                )
                .navigationDestination(for: Destination.self) { destination in
                    switch destination {
                    case .detail(let movie):
                        DetailView(
                            viewModel: DetailViewModel(
                                movie: movie,
                                movieRepository: IMDBMovieRepository(),
                                watchListRepository: viewModel.watchListRepository
                            )
                        )
                    }
                }
            }
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }

            NavigationStack(path: $viewModel.watchListTabPath) {
                WatchList(
                    viewModel: WatchListViewModel(watchListRepository: viewModel.watchListRepository),
                    navigateTo: { destination in viewModel.watchListTabPath.append(destination)}
                )
                .navigationDestination(for: Destination.self) { destination in
                    switch destination {
                    case .detail(let movie):
                        DetailView(
                            viewModel: DetailViewModel(
                                movie: movie,
                                movieRepository: IMDBMovieRepository(),
                                watchListRepository: viewModel.watchListRepository
                            )
                        )
                    }
                }
            }
            .tabItem {
                Label("Watch List", systemImage: "bookmark")
            }
        }
    }

    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .imdbBackground
        appearance.stackedLayoutAppearance.selected.iconColor = .systemBlue
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.systemBlue
        ]
        appearance.stackedLayoutAppearance.normal.iconColor = .white.withAlphaComponent(0.5)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor:  UIColor.white.withAlphaComponent(0.5)
        ]

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    private func setupNavBarAppearance() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor.imdbBackground

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().tintColor = .white

        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .lightGray
    }
}

#Preview {
    TabbedView(viewModel: TabbedViewModel())
}
