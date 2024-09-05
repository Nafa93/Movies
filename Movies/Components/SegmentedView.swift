//
//  SegmentedView.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 05/09/2024.
//

import SwiftUI

enum Segment: CaseIterable, Identifiable {
    case about, reviews, cast, nowPlaying, upcoming, topRated

    var id: Self { self }

    var title: String {
        switch self {
        case .about:
            "About Movie"
        case .reviews:
            "Reviews"
        case .cast:
            "Cast"
        case .nowPlaying:
            "Now Playing"
        case .upcoming:
            "Upcoming"
        case .topRated:
            "Top Rated"
        }
    }

    static var detailSegments: [Segment] {
        [.about, .reviews, .cast]
    }

    static var homeSegments: [Segment] {
        [.nowPlaying, .upcoming, .topRated]
    }
}

struct SegmentedView: View {
    @Binding var selected: Segment
    @Namespace var name
    let segments: [Segment]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(segments, id: \.self) { segment in
                Button {
                    selected = segment
                } label: {
                    VStack {
                        Text(segment.title)
                            .font(.regular(14))
                            .foregroundColor(selected == segment ? .gray : .white)
                        ZStack {
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 4)
                            if selected == segment {
                                Capsule()
                                    .fill(Color.gray)
                                    .frame(height: 4)
                                    .matchedGeometryEffect(id: "Tab", in: name)
                            }
                        }
                    }
                }
            }
        }
    }
}
