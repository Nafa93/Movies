//
//  Search.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 05/09/2024.
//

import SwiftUI

struct Search: View {
    @Environment(\.dismiss) private var dismiss
    @State var viewModel: SearchViewModel

    var navigateTo: (_ destination: Destination) -> ()
    
    var body: some View {
        ScrollView(.vertical) {
            if !viewModel.searchQuery.isEmpty {
                SearchOverlay(viewModel: viewModel, navigateTo: navigateTo)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ZStack(alignment: .center) {
                    VStack(spacing: 12) {
                        Image("Search")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 76, height: 76)

                        Text("We are sorry, we can not find the movie :(")
                            .frame(width: 200)
                            .multilineTextAlignment(.center)
                            .font(.regular(16))
                            .foregroundStyle(.white)

                        Text("Find your movie by Type title, categories, years, etc")
                            .frame(width: 200)
                            .multilineTextAlignment(.center)
                            .font(.regular(12))
                            .foregroundStyle(.gray)
                    }
                    .frame(minHeight: 600, maxHeight: .infinity)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.imdbBackground)
        .searchable(
            text: $viewModel.searchQuery,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search"
        )
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Search")
                    .font(.regular(16))
                    .foregroundStyle(Color.white)
            }
        }
    }
}

#Preview {
    NavigationStack {
        Search(viewModel: SearchViewModel()) { _ in }
    }
}
