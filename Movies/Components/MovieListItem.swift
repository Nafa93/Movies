//
//  MovieListItem.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 05/09/2024.
//

import SwiftUI

struct MovieListItem: View {
    var title: String
    var rating: Double
    var releaseYear: String
    var genre: String?
    var runtime: String?
    var url: URL?

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 12) {
                IMDBAsyncImage(url: url, width: 95, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                VStack(alignment: .leading, spacing: 12) {
                    Text(title)
                        .font(.regular(16))
                        .foregroundStyle(.white)

                    Rating(rating: rating, horizontalPadding: 0, verticalPadding: 0)

                    HStack {
                        Image(systemName: "calendar")
                        Text(releaseYear)
                    }
                    .font(.regular(12))
                    .foregroundStyle(.white)

                    if let genre = genre {
                        HStack {
                            Image(systemName: "ticket")
                            Text(genre)
                        }
                        .font(.regular(12))
                        .foregroundStyle(.white)
                    }

                    if let runtime = runtime {
                        HStack {
                            Image(systemName: "clock")
                            Text("\(runtime) minutes")
                        }
                        .font(.regular(12))
                        .foregroundStyle(.white)
                    }
                }

                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
        }
    }
}
