//
//  IMDBAsyncImage.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 05/09/2024.
//

import SwiftUI

struct IMDBAsyncImage: View {
    var url: URL?
    var width: CGFloat
    var height: CGFloat

    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: width)

        } placeholder: {
            Color.gray
                .frame(height: height)
                .frame(maxWidth: width)
        }
    }
}
