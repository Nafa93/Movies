//
//  ReviewsResponse.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 05/09/2024.
//

import Foundation

struct ReviewsResponse: Codable, Equatable {
    let results: [Review]
}
