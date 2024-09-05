//
//  LocalMovieRepository.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 04/09/2024.
//

import Foundation

class LocalMovieRepository: MovieRepository {

    private var movieList: [Movie] = [
        Movie(
            id: 0,
            genres: [
                Genre(
                    id: 0,
                    name: nil
                )
            ],
            title: "Deadpool & Wolverine",
            overview: "A listless Wade Wilson toils away in civilian life with his days as the morally flexible mercenary, Deadpool, behind him. But when his homeworld faces an existential threat, Wade must reluctantly suit-up again with an even more reluctant Wolverine.",
            poster: "/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
            releaseDate: "2024-07-24",
            runtime: 200,
            voteAverage: 8.231,
            backdrop: "7aPrv2HFssWcOtpig5G3HEVk3uS.jpg",
            videos: nil,
            reviews: nil,
            credits: nil
        ),
        Movie(
            id: 1,
            genres: [
                Genre(
                    id: 0,
                    name: nil
                )
            ],
            title: "Inside Out 2",
            overview: "Teenager Riley's mind headquarters is undergoing a sudden demolition to make room for something entirely unexpected: new Emotions! Joy, Sadness, Anger, Fear and Disgust, who’ve long been running a successful operation by all accounts, aren’t sure how to feel when Anxiety shows up. And it looks like she’s not alone.",
            poster: "/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg",
            releaseDate: "2024-07-24",
            runtime: 200,
            voteAverage: 8.231,
            backdrop: "7aPrv2HFssWcOtpig5G3HEVk3uS.jpg",
            videos: nil,
            reviews: nil,
            credits: nil
        ),
        Movie(
            id: 2,
            genres: [
                Genre(
                    id: 0,
                    name: nil
                )
            ],
            title: "Despicable Me 4",
            overview: "Gru and Lucy and their girls—Margo, Edith and Agnes—welcome a new member to the Gru family, Gru Jr., who is intent on tormenting his dad. Gru also faces a new nemesis in Maxime Le Mal and his femme fatale girlfriend Valentina, forcing the family to go on the run.",
            poster: "/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
            releaseDate: "2024-07-24",
            runtime: 200,
            voteAverage: 8.231,
            backdrop: "7aPrv2HFssWcOtpig5G3HEVk3uS.jpg",
            videos: nil,
            reviews: nil,
            credits: nil
        ),
        Movie(
            id: 3,
            genres: [
                Genre(
                    id: 0,
                    name: nil
                )
            ],
            title: "Bad Boys: Ride or Die",
            overview: "After their late former Captain is framed, Lowrey and Burnett try to clear his name, only to end up on the run themselves.",
            poster: "/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
            releaseDate: "2024-07-24",
            runtime: 200,
            voteAverage: 8.231,
            backdrop: "7aPrv2HFssWcOtpig5G3HEVk3uS.jpg",
            videos: nil,
            reviews: nil,
            credits: nil
        ),
        Movie(
            id: 4,
            genres: [
                Genre(
                    id: 0,
                    name: nil
                )
            ],
            title: "Twisters",
            overview: "As storm season intensifies, the paths of former storm chaser Kate Carter and reckless social-media superstar Tyler Owens collide when terrifying phenomena never seen before are unleashed. The pair and their competing teams find themselves squarely in the paths of multiple storm systems converging over central Oklahoma in the fight of their lives.",
            poster: "/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
            releaseDate: "2024-07-24",
            runtime: 200,
            voteAverage: 8.231,
            backdrop: "7aPrv2HFssWcOtpig5G3HEVk3uS.jpg",
            videos: nil,
            reviews: nil,
            credits: nil
        ),
        Movie(
            id: 5,
            genres: [
                Genre(
                    id: 0,
                    name: nil
                )
            ],
            title: "Longlegs",
            overview: "FBI Agent Lee Harker is assigned to an unsolved serial killer case that takes an unexpected turn, revealing evidence of the occult. Harker discovers a personal connection to the killer and must stop him before he strikes again.",
            poster: "/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
            releaseDate: "2024-07-24",
            runtime: 200,
            voteAverage: 8.231,
            backdrop: "7aPrv2HFssWcOtpig5G3HEVk3uS.jpg",
            videos: nil,
            reviews: nil,
            credits: nil
        )
    ]

    func getPopular() -> [Movie] {
        return Array(movieList.prefix(3))
    }

    func getNowPlaying() -> [Movie] {
        return movieList
    }

    func getUpcoming() -> [Movie] {
        return movieList
    }

    func getTopRated() -> [Movie] {
        return movieList
    }

    func getDetail(id: Int) -> Movie? {
        return movieList.first(where: { $0.id == id })
    }

    func search(_ query: String) async throws -> [Movie] {
        return []
    }
}
