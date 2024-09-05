//
//  JSONWatchListRespository.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 05/09/2024.
//

import Foundation

class JSONWatchListRespository: WatchListRepository {
    private let directoryURL: URL
    private let fileName: String
    private var watchList: [Movie] = []

    init(fileName: String = "watchlist", subdirectory: String? = nil) {
        self.fileName = fileName
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        if let subdirectory = subdirectory {
            self.directoryURL = documentsURL.appendingPathComponent(subdirectory, isDirectory: true)
            if !FileManager.default.fileExists(atPath: directoryURL.path) {
                try? FileManager.default.createDirectory(
                    at: directoryURL,
                    withIntermediateDirectories: true,
                    attributes: nil
                )
            }
        } else {
            self.directoryURL = documentsURL
        }
    }

    func get(_ id: Int) -> Movie? {
        if let index = watchList.firstIndex(where: { $0.id == id }) {
            return watchList[index]
        }

        return nil
    }

    func getAll() throws -> [Movie] {
        let fileURL = directoryURL.appendingPathComponent(fileName)
        let jsonData = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        let data = try decoder.decode([Movie].self, from: jsonData)

        watchList = data

        return data
    }

    func remove(_ movie: Movie) throws {
        if let index = watchList.firstIndex(of: movie) {
            watchList.remove(at: index)
        }

        try saveAll(watchList)
    }

    func save(_ movie: Movie) throws {
        watchList.append(movie)
        try saveAll(watchList)
    }

    internal func saveAll(_ movies: [Movie]) throws {
        let fileURL = directoryURL.appendingPathComponent(fileName)
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(movies)
        try jsonData.write(to: fileURL, options: [.atomicWrite, .completeFileProtection])
    }
}
