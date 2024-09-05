//
//  DetailView.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 04/09/2024.
//

import SwiftUI

struct DetailView: View {
    @State var viewModel: DetailViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 80) {
                VStack {
                    ZStack(alignment: .bottomLeading) {
                        ZStack(alignment: .center) {
                            IMDBAsyncImage(url: viewModel.backdropUrl, width: .infinity, height: 200)

                            Image(systemName: "play.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 48, height: 48)
                                .foregroundStyle(.white)
                        }
                        .onTapGesture {
                            viewModel.presentVideo()
                        }

                        HStack {
                            Spacer()

                            Rating(rating: viewModel.rating)
                        }
                        .padding([.bottom, .trailing], 8)

                        HStack(alignment: .bottom) {
                            IMDBAsyncImage(url: viewModel.posterUrl, width: 95, height: 120)

                            Text(viewModel.title)
                                .font(.semiBold(18))
                                .foregroundStyle(Color.white)
                        }
                        .padding(.horizontal, 24)
                        .offset(y: 60)
                    }
                }

                VStack(spacing: 24) {
                    SegmentedDetails(releaseYear: viewModel.releaseYear, runtime: viewModel.runtime, genre: viewModel.genre)

                    SegmentedView(selected: $viewModel.selectedSegment, segments: Segment.detailSegments)
                        .padding(.horizontal, 24)

                    switch viewModel.selectedSegment {
                    case .about:
                        Text(viewModel.overview)
                            .font(.regular(16))
                            .foregroundStyle(Color.white)
                            .padding(.horizontal, 24)
                    case .reviews:
                        ForEach(viewModel.reviews, id: \.self) { review in
                            ReviewView(
                                author: review.author,
                                rating: review.authorDetails.rating,
                                content: review.content
                            )
                        }
                        .padding(.horizontal, 24)
                    case .cast:
                        Text(viewModel.cast)
                            .font(.regular(16))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 24)
                    default:
                        EmptyView()
                    }
                }

                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.imdbBackground)
        .task {
            await viewModel.getDetails()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color.white)
                }
            }

            ToolbarItem(placement: .principal) {
                Text("Detail")
                    .font(.regular(16))
                    .foregroundStyle(Color.white)
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.isBookmarked.toggle()
                    viewModel.upsertInWatchList()
                } label: {
                    Image(systemName: viewModel.isBookmarked ? "bookmark.fill" : "bookmark")
                        .foregroundStyle(Color.white)
                }
            }
        }
        .fullScreenCover(item: $viewModel.presentedVideo, content: { item in
            ZStack(alignment: .topTrailing) {
                Color.imdbBackground.ignoresSafeArea(edges: .all)

                Button {
                    viewModel.presentedVideo = nil
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(12)
                        .background(Color.imdbBackground)
                }
                .foregroundStyle(.white)

                VStack {
                    Spacer()

                    YouTubeView(videoId: item.id)
                        .frame(maxWidth: .infinity, maxHeight: 300)

                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        })
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationStack {
        DetailView(
            viewModel: DetailViewModel(
                movie: Movie(
                    id: 1,
                    genres: [.init(id: 0, name: "Action")],
                    title: "Deadpool & Wolverine",
                    overview: "A listless Wade Wilson toils away in civilian life with his days as the morally flexible mercenary, Deadpool, behind him. But when his homeworld faces an existential threat, Wade must reluctantly suit-up again with an even more reluctant Wolverine.",
                    poster: "/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
                    releaseDate: "2024-07-24",
                    runtime: 128,
                    voteAverage: 7.755,
                    backdrop: "/yDHYTfA3R0jFYba16jBB1ef8oIt.jpg",
                    videos: VideosResponse(
                        results: [
                            Video(key: "nY5IAhjTclY", type: "Teaser", site: "YouTube")
                        ]
                    ),
                    reviews: ReviewsResponse(
                        results: [
                            Review(id: "2", author: "John Doe", content: "This was a good movie", authorDetails: AuthorDetails(rating: 8))
                        ]
                    ),
                    credits: CreditsResponse(
                        cast: [
                            Cast(name: "Ryan Reynolds"),
                            Cast(name: "Hugh Jackman")
                        ]
                    )
                ),
                movieRepository: LocalMovieRepository(), 
                watchListRepository: LocalWatchListRepository()
            )
        )
    }
}
