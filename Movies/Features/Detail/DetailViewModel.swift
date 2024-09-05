//
//  DetailViewModel.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 05/09/2024.
//

import Foundation

struct VideoItem: Identifiable {
    let id: String
}

@Observable class DetailViewModel {
    private let movieRepository: MovieRepository
    private let watchListRepository: WatchListRepository
    private var movie: Movie
    var selectedSegment: Segment = .about
    var isBookmarked = false
    var presentedVideo: VideoItem?

    init(movie: Movie, movieRepository: MovieRepository, watchListRepository: WatchListRepository) {
        self.movie = movie
        self.movieRepository = movieRepository
        self.watchListRepository = watchListRepository
        self.isBookmarked = watchListRepository.get(movie.id) != nil
    }

    var backdropUrl: URL? {
        guard let backdrop = movie.backdrop else { return nil }
        return URL(string: "\(AppEnvironment.imageBaseUrl)\(backdrop)")
    }

    var posterUrl: URL? {
        guard let poster = movie.poster else { return nil }
        return URL(string: "\(AppEnvironment.imageBaseUrl)\(poster)")
    }

    var rating: Double {
        Double(round(movie.voteAverage * 10.0) / 10.0)
    }

    var title: String {
        movie.title
    }

    var genre: String {
        movie.genres?.first?.name ?? "No genre"
    }

    var releaseYear: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: movie.releaseDate) {
            return String(date.get(.year))
        }

        return "Unknown"
    }

    var runtime: String {
        String(movie.runtime ?? 0)
    }

    var overview: String {
        movie.overview
    }

    var reviews: [Review] {
        movie.reviews?.results ?? []
    }

    var cast: String {
        let everyName = movie.credits?.cast.map{ $0.name }
        return everyName?.joined(separator: ", ") ?? "Cast unavailable"
    }

    func getDetails() async {
        do {
            guard let movie = try await movieRepository.getDetail(id: movie.id) else {
                return
            }

            self.movie = movie
        } catch {
            print(error)
        }
    }

    func upsertInWatchList() {
        do {
            if isBookmarked {
                try watchListRepository.save(movie)
            } else {
                try watchListRepository.remove(movie)
            }
        } catch {
            print(error)
        }
    }

    func presentVideo() {
        presentedVideo = VideoItem(id: movie.videos?.results.first?.key ?? "")
    }
}
