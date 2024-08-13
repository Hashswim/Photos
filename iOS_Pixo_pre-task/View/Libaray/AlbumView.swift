//
//  AlbumView.swift
//  iOS_Pixo_pre-task
//
//  Created by 서수영 on 8/13/24.
//

import SwiftUI

struct AlbumView: View {

    private var testArr: [Color] = [.red,.orange, .yellow, .green, .blue, .purple, .pink]

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(testArr, id: \.self) { color in
                        ZStack {
                            Color.gray
                            VStack {
                                getAlbumContainer()

                                Divider()

                                getAlbumContainer()
                            }
                            .padding(.vertical)
                        }
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .scrollTransition { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1 : 0.5)
                                .scaleEffect(y: phase.isIdentity ? 1 : 0.8)
                        }
                    }
                }
                .padding(.horizontal, geometry.size.width * 0.05)
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
        }
    }

    @ViewBuilder
    func getAlbumContainer() -> some View {
        GeometryReader { geometry in
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text("네이버 앨범")
                    Text("5")
                }

                Spacer()

                Rectangle()
                    .fill(Color.green)
                    .frame(width: geometry.size.width * 0.4)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    AlbumView()
}
