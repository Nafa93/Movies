//
//  IMDBMovieRepository.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 04/09/2024.
//

import Foundation

enum AppEnvironment {
    enum Keys {
        static let apiKey = "API_KEY"
        static let baseUrl = "BASE_URL"
        static let imageBaseUrl = "IMAGE_BASE_URL"
    }

    private static let infoDictionary: [String: Any] = {
        guard let dictionary = Bundle.main.infoDictionary else {
            fatalError("Info.plist not found")
        }

        return dictionary
    }()

    static let baseUrl: String = {
        guard let baseUrl = AppEnvironment.infoDictionary[Keys.baseUrl] as? String else {
            fatalError("Base url not set in Info.plist")
        }

        return baseUrl
    }()

    static let imageBaseUrl: String = {
        guard let imageBaseUrl = AppEnvironment.infoDictionary[Keys.imageBaseUrl] as? String else {
            fatalError("Image base url not set in Info.plist")
        }

        return imageBaseUrl
    }()

    static let apiKey: String = {
        guard let apiKey = AppEnvironment.infoDictionary[Keys.apiKey] as? String else {
            fatalError("API key not set in Info.plist")
        }

        return apiKey
    }()
}

enum Endpoint {
    case popular, nowPlaying, upcoming, topRated, detail(Int), search(String)

    var url: URL? {
        switch self {
        case .popular:
            return URL(string: "\(AppEnvironment.baseUrl)movie/popular?api_key=\(AppEnvironment.apiKey)")
        case .nowPlaying:
            return URL(string: "\(AppEnvironment.baseUrl)movie/now_playing?api_key=\(AppEnvironment.apiKey)")
        case .upcoming:
            return URL(string: "\(AppEnvironment.baseUrl)movie/upcoming?api_key=\(AppEnvironment.apiKey)")
        case .topRated:
            return URL(string: "\(AppEnvironment.baseUrl)movie/top_rated?api_key=\(AppEnvironment.apiKey)")
        case .detail(let id):
            return URL(string: "\(AppEnvironment.baseUrl)movie/\(id)?api_key=\(AppEnvironment.apiKey)&language=en-US&append_to_response=videos,reviews,credits")
        case .search(let search):
            return URL(string: "\(AppEnvironment.baseUrl)search/movie?api_key=\(AppEnvironment.apiKey)&query=\(search)")
        }
    }
}

class Networking {
    enum Errors: Error {
        case invalidUrl
    }

    private let session = URLSession.shared

    func request<T: Codable>(_ endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url else { throw Errors.invalidUrl }
        let (data, _) = try await session.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}

class IMDBMovieRepository: MovieRepository {

    private let networking: Networking

    init(networking: Networking = Networking()) {
        self.networking = networking
    }

    func getPopular() async throws -> [Movie] {
        let response: MoviesResponse = try await networking.request(.popular)
        return response.results
    }

    func getNowPlaying() async throws -> [Movie] {
        let response: MoviesResponse = try await networking.request(.nowPlaying)
        return response.results
    }

    func getUpcoming() async throws -> [Movie] {
        let response: MoviesResponse = try await networking.request(.upcoming)
        return response.results
    }

    func getTopRated() async throws -> [Movie] {
        let response: MoviesResponse = try await networking.request(.topRated)
        return response.results
    }

    func getDetail(id: Int) async throws -> Movie? {
        return try await networking.request(.detail(id))
    }

    func search(_ query: String) async throws -> [Movie] {
        let response: MoviesResponse = try await networking.request(.search(query))
        return response.results
    }
}
