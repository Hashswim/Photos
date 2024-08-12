//
//  MemoryView.swift
//  iOS_Pixo_pre-task
//  iOS 신입 지원자 서수영
//

import SwiftUI

struct MemoryView: View {

    @State private var scale: CGFloat = 1.0
    @State private var isFavorite: Bool = false

    var body: some View {
        GeometryReader { geometry in
            let itemWidth: CGFloat = geometry.size.width * 0.9
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(images, id: \.id) { image in
                        Image(image.image)
                            .resizable()
                            .scaledToFill()
                            .scaleEffect(scale)
                            .onAppear() {
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
                    }
                }
                .scrollTargetLayout()
                .safeAreaPadding(.horizontal)
            }
            .scrollTargetBehavior(.viewAligned)
        }
    }
}
