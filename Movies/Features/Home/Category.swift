//
//  Category.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 04/09/2024.
//

import Foundation

enum Category: Identifiable, CaseIterable {
    case nowPlaying, upcoming, topRated

    var id: Self { self }

    var title: String {
        switch self {
        case .nowPlaying:
            "Now Playing"
        case .upcoming:
            "Upcoming"
        case .topRated:
            "Top Rated"
        }
    }
}
