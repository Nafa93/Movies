//
//  Movie.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 04/09/2024.
//

import Foundation

struct Movie: Codable, Identifiable, Equatable {
    let id: Int
    let genres: [Genre]?
    let title: String
    let overview: String
    let poster: String?
    let releaseDate: String
    let runtime: Int?
    let voteAverage: Float
    let backdrop: String?
    let videos: VideosResponse?
    let reviews: ReviewsResponse?
    let credits: CreditsResponse?

    enum CodingKeys: String, CodingKey {
        case id
        case genres = "genres"
        case title
        case overview
        case poster = "poster_path"
        case releaseDate = "release_date"
        case runtime
        case voteAverage = "vote_average"
        case backdrop = "backdrop_path"
        case videos = "videos"
        case reviews = "reviews"
        case credits = "credits"
    }
}
