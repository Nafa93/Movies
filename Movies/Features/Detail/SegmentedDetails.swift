//
//  SegmentedDetails.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 05/09/2024.
//

import SwiftUI

struct SegmentedDetails: View {
    var releaseYear: String
    var runtime: String
    var genre: String

    var body: some View {
        HStack {
            Image(systemName: "calendar")

            Text(releaseYear)

            Text("|")

            Image(systemName: "clock")

            Text("\(runtime) minutes")

            Text("|")

            Image(systemName: "ticket")

            Text(genre)
        }
        .font(.semiBold(12))
        .foregroundStyle(Color.gray)
    }
}
