//
//  MovieListHorizontal.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 04/09/2024.
//

import SwiftUI

struct MovieHorizontalList: View {
    @Binding var movies: [Movie]

    var imageUrl: (Movie) -> URL?

    var onItemTapped: (Movie) -> ()

    var body: some View {
        HStack(spacing: 32) {
            ForEach(0..<movies.count, id: \.self) { index in
                ZStack(alignment: .bottomLeading) {
                    AsyncImage(url: imageUrl(movies[index])) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 144, height: 210)
                    } placeholder: {
                        Color.gray
                            .frame(width: 144, height: 210)
                    }

                    Text("\(index + 1)")
                        .font(.semiBold(96))
                        .offset(x: -15, y: 55)
                }
                .onTapGesture {
                    onItemTapped(movies[index])
                }
            }
        }
    }
}
