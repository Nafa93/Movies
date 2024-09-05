//
//  WatchListRepository.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 05/09/2024.
//

import Foundation

protocol WatchListRepository {
    func get(_ id: Int) -> Movie?
    func getAll() throws -> [Movie]
    func remove(_ movie: Movie) throws
    func save(_ movie: Movie) throws
    func saveAll(_ movies: [Movie]) throws
}
