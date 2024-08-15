//
//  AlbumGridView.swift
//  iOS_Pixo_pre-task
//  iOS 신입 지원자 서수영
//

import SwiftUI

struct AlbumGridView: View {
    var album: AlbumType

    var body: some View {
        let photoList = PhotoData.shared.photos.filter { $0.album == album }

        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
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
