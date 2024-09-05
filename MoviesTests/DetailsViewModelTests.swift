//
//  DetailsViewModelTests.swift
//  DetailsViewModelTests
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 03/09/2024.
//

import XCTest
@testable import Movies

final class DetailsViewModelTests: XCTestCase {
    func test_releaseYear_returnsCorrectNumber() throws {
        let viewModel = DetailViewModel(
            movie: .init(
                id: 0,
                genres: nil,
                title: "Deadpool",
                overview: "Overview",
                poster: nil,
                releaseDate: "2024-02-02",
                runtime: nil,
                voteAverage: 10.0,
                backdrop: nil,
                videos: nil,
                reviews: nil,
                credits: nil
            ),
            movieRepository: LocalMovieRepository(),
            watchListRepository: LocalWatchListRepository()
        )

        let releaseYear = viewModel.releaseYear

        XCTAssertTrue(releaseYear == "2024")
    }

    func test_releaseYear_returnsUnknown_ifDateIsWrong() throws {
        let viewModel = DetailViewModel(
            movie: .init(
                id: 0,
                genres: nil,
                title: "Deadpool",
                overview: "Overview",
                poster: nil,
                releaseDate: "",
                runtime: nil,
                voteAverage: 10.0,
                backdrop: nil,
                videos: nil,
                reviews: nil,
                credits: nil
            ),
            movieRepository: LocalMovieRepository(),
            watchListRepository: LocalWatchListRepository()
        )

        let releaseYear = viewModel.releaseYear

        XCTAssertTrue(releaseYear == "Unknown")
    }
}
