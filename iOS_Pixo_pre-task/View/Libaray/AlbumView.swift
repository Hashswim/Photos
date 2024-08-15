//
//  AlbumView.swift
//  iOS_Pixo_pre-task
//
//  Created by 서수영 on 8/13/24.
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

struct GetAlbumContainer: View {
    var type: AlbumType
    var photoList: [ImageModel] {
        PhotoData.shared.photos.filter { $0.album == type }
    }

    @State var isShowingAlbum: Bool = false

    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(type.name)
                        .font(.headline)
                    Text("\(photoList.count) Photos")
                        .font(.caption)
                }

                Spacer()

                if let img = photoList.first?.image {
                    Image(img)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width * 0.4, height: geometry.size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .clipped()
                } else {
                    Color.gray
                        .frame(width: geometry.size.width * 0.4, height: geometry.size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
            }
            .onTapGesture {
                isShowingAlbum.toggle()
            }
            .padding(.horizontal)
        }
        .sheet(isPresented: $isShowingAlbum) {
            AlbumGridView(album: type)
        }
    }
}

struct AlbumGridView: View {
    var album: AlbumType

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        let photoList = PhotoData.shared.photos.filter { $0.album == album }

        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                Text(album.name)
                    .font(.headline.bold())

                ForEach(photoList, id: \.self) { photo in
                    Image(photo.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .clipped()
                }
            }
            .padding()
        }
        .navigationTitle(album.name)
    }
}

#Preview {
    AlbumView()
}
