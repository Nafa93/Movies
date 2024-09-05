//
//  Tab.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 04/09/2024.
//

import SwiftUI

enum Tab: Identifiable, CaseIterable {
    case home, search, watchList

    var id: Int {
        switch self {
        case .home:
            1
        case .search:
            2
        case .watchList:
            3
        }
    }

    var title: String {
        switch self {
        case .home:
            "Home"
        case .search:
            "Search"
        case .watchList:
            "Watch List"
        }
    }

    var systemImage: String {
        switch self {
        case .home:
            "house"
        case .search:
            "magnifyingglass"
        case .watchList:
            "bookmark"
        }
    }
}
