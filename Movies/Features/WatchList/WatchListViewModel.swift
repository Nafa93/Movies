//
//  WatchListViewModel.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 05/09/2024.
//

import Foundation

@Observable class WatchListViewModel {
    var watchList: [Movie] = []
    var watchListRepository: WatchListRepository

    init(watchListRepository: WatchListRepository) {
        self.watchListRepository = watchListRepository
    }

    func imageUrl(for movie: Movie) -> URL? {
        guard let poster = movie.poster else { return nil }
        return URL(string: "\(AppEnvironment.imageBaseUrl)\(poster)")
    }

    func title(for movie: Movie) -> String {
        movie.title
    }

    func rating(for movie: Movie) -> Double {
        Double(round(movie.voteAverage * 10.0) / 10.0)
    }

    func releaseYear(for movie: Movie) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: movie.releaseDate) {
            return String(date.get(.year))
        }

        return "Unknown"
    }

    func genre(for movie: Movie) -> String? {
        movie.genres?.first?.name
    }

    func runtime(for movie: Movie) -> String? {
        if let runtime = movie.runtime {
            return "\(runtime)"
        }

        return nil
    }

    func getWatchList() {
        do {
            self.watchList = try self.watchListRepository.getAll()
        } catch {
            print(error)
        }
    }
}
