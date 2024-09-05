//
//  LocalWatchListRepository.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 05/09/2024.
//

import Foundation

class LocalWatchListRepository: WatchListRepository {

    private var localWatchList: [Movie] = []

    func get(_ id: Int) -> Movie? {
        if let index = localWatchList.firstIndex(where: { $0.id == id }) {
            return localWatchList[index]
        }

        return nil
    }

    func getAll() throws -> [Movie] {
        return localWatchList
    }
    
    func remove(_ movie: Movie) throws {
        if let index = localWatchList.firstIndex(of: movie) {
            localWatchList.remove(at: index)
        }
    }

    func save(_ movie: Movie) throws {
        localWatchList.append(movie)
    }

    func saveAll(_ movies: [Movie]) throws {
        localWatchList = movies
    }
}
