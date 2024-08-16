//
//  MemoryView.swift
//  iOS_Pixo_pre-task
//  iOS 신입 지원자 서수영
//

import SwiftUI

struct MemoryView: View {
    @State private var scale: CGFloat = 1.0
    @State private var isFavorite: Bool = false
    @State private var selectedItem: ImageModel? = nil

    var body: some View {
        GeometryReader { geometry in
            let itemWidth: CGFloat = geometry.size.width * 0.9
            ScrollView(.horizontal, showsIndicators: false) {
                HStack() {
                    ForEach(PhotoData.shared.photos.filter {
                        $0.memoryText != ""
                    }, id: \.id) { image in
                        Image(image.image)
                            .resizable()
                            .scaledToFill()
                            .scaleEffect(scale)
                            .onAppear {
                                withAnimation(.easeInOut(duration: 10.0).repeatForever(autoreverses: true)) {
                                    scale = 1.1
                                }
                            }
                            .frame(width: itemWidth, height: 480)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .overlay(alignment: .bottom) {
                                Text("\(image.memoryText)")
                                    .font(.largeTitle.bold())
                                    .frame(alignment: .bottom)
                                    .foregroundStyle(Color.white)
                                    .padding(.bottom)
                            }
                            .onTapGesture {
                                selectedItem = image
                            }
                    }
                }
                .scrollTargetLayout()
            }
            .fullScreenCover(item: $selectedItem){ item in
                ImageCardView(imageModel: item)
            }
            .contentMargins(.horizontal, geometry.size.width * 0.05)
            .scrollTargetBehavior(.viewAligned)
        }
    }
}
