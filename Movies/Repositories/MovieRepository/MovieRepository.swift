//
//  MovieRepository.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 04/09/2024.
//

import Foundation

protocol MovieRepository {
    func getPopular() async throws -> [Movie]
    func getNowPlaying() async throws -> [Movie]
    func getUpcoming() async throws -> [Movie]
    func getTopRated() async throws -> [Movie]
    func getDetail(id: Int) async throws -> Movie?
    func search(_ query: String) async throws -> [Movie]
}
