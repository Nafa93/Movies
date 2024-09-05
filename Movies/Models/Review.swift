//
//  Review.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 05/09/2024.
//

import Foundation

struct Review: Codable, Equatable, Hashable {
    let id: String
    let author: String
    let content: String
    let authorDetails: AuthorDetails

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(author)
        hasher.combine(content)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case author
        case content
        case authorDetails = "author_details"
    }
}
