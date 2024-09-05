//
//  HomeViewModel.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 04/09/2024.
//

import Foundation

@Observable class HomeViewModel {
    private var repository: MovieRepository

    var selectedCategory: Segment = .nowPlaying
    var popular: [Movie] = []
    var nowPlaying: [Movie] = []
    var topRated: [Movie] = []
    var upcoming: [Movie] = []

    init(repository: MovieRepository) {
        self.repository = repository
    }

    func imageUrl(for movie: Movie) -> URL? {
        guard let poster = movie.poster else { return nil }
        return URL(string: "\(AppEnvironment.imageBaseUrl)\(poster)")
    }

    func getPopular() async {
        do {
            self.popular = try await self.repository.getPopular()
        } catch {
            print(error)
        }
    }

    func getNowPlaying() async {
        do {
            let nowPlaying = try await self.repository.getNowPlaying()
            self.nowPlaying = Array(nowPlaying.prefix(6))
        } catch {
            print(error)
        }
    }

    func getUpcoming() async {
        do {
            let upcoming = try await self.repository.getUpcoming()
            self.upcoming = Array(upcoming.prefix(6))
        } catch {
            print(error)
        }
    }

    func getTopRated() async {
        do {
            let topRated = try await self.repository.getTopRated()
            self.topRated = Array(topRated.prefix(6))
        } catch {
            print(error)
        }
    }
}
