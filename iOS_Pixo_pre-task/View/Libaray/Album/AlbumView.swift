//
//  AlbumView.swift
//  iOS_Pixo_pre-task
//  iOS 신입 지원자 서수영
//

import SwiftUI

struct AlbumView: View {

    private let albumTypes = AlbumType.allCases
    private let albumcount = AlbumType.allCases.count

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack() {
                    ForEach(0..<albumcount/2, id: \.self) { i in
                        ZStack {
                            Color.secondary
                            VStack {
                                GetAlbumContainer(type: albumTypes[i*2])

                                Divider()

                                if albumcount >= (i*2 + 1) {
                                    GetAlbumContainer(type: albumTypes[i*2 + 1])
                                }
                            }
                            .padding(.vertical)
                        }
                        .frame(width: geometry.size.width * 0.85, height: geometry.size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .scrollTransition { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1 : 0.5)
                                .scaleEffect(y: phase.isIdentity ? 1 : 0.8)
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .contentMargins(.horizontal, geometry.size.width * 0.075)
            .scrollTargetBehavior(.viewAligned)
        }
    }
}

#Preview {
    AlbumView()
}
