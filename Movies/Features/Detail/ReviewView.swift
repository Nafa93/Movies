//
//  ReviewView.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 05/09/2024.
//

import SwiftUI

struct ReviewView: View {
    var author: String
    var rating: Int?
    var content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(author)
                    .font(.semiBold(16))

                Spacer()

                if let rating = rating {
                    Rating(rating: Double(rating))
                }
            }

            Text(content)
                .font(.regular(16))
        }
        .foregroundStyle(.white)
    }
}
