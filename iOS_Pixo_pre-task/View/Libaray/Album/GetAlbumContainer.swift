//
//  GetAlbumContainer.swift
//  iOS_Pixo_pre-task
//  iOS 신입 지원자 서수영
//

import SwiftUI

struct GetAlbumContainer: View {
    var type: AlbumType
    var photoList: [ImageModel] {
        PhotoData.shared.photos.filter { $0.album == type }
    }

    @State private var selectedType: AlbumType? = nil

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
                selectedType = type
            }
            .padding(.horizontal)
        }
        .sheet(item: $selectedType) { type in
            AlbumGridView(album: type)
        }
    }
}
