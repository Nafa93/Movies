//
//  MovieGrid.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 04/09/2024.
//

import SwiftUI

struct MovieGrid: View {
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: columnSize)
    }

    var columnSize: Int

    var movies: [Movie]

    var imageUrl: (Movie) -> URL?

    var onItemTapped: (Movie) -> Void

    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(movies) { movie in
                AsyncImage(url: imageUrl(movie)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 144)
                } placeholder: {
                    Color.gray
                        .frame(width: 100, height: 144)
                }
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .onTapGesture {
                    onItemTapped(movie)
                }
            }
        }
    }
}
