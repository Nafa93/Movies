//
//  Rating.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 05/09/2024.
//

import SwiftUI

struct Rating: View {
    var rating: Double
    var horizontalPadding: CGFloat = 8
    var verticalPadding: CGFloat = 4

    var body: some View {
        HStack {
            Image(systemName: "star")

            Text(String(format: "%.1f", rating))
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.vertical, verticalPadding)
        .background(Color.imdbBackground)
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .foregroundStyle(.orange)
        .font(.semiBold(12))
    }
}
