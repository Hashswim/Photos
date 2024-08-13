//
//  CoverCarousel.swift
//  iOS_Pixo_pre-task
//
//  Created by 서수영 on 8/12/24.
//

import SwiftUI

struct CoverCarousel<Content: View, Data: RandomAccessCollection>: View where Data.Element: Identifiable {
    var data: Data
    @ViewBuilder var content: (Data.Element) -> Content
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(data) { item in
                        NavigationLink(
                            destination: ImageCardView(imageModel: item as! ImageModel)
                        ) {
                            ItemView(item)
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .safeAreaPadding(.horizontal, (geometry.size.width - 300) / 2)
            .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
            .scrollIndicators(.hidden)
        }
    }

    @ViewBuilder
    func ItemView(_ item: Data.Element) -> some View {
        GeometryReader { geometry in
            let minX = geometry.frame(in: .scrollView(axis: .horizontal)).minX
            let progress = minX / (310)

            let diffWidth: CGFloat = 260 //300 - 40
            let reducingWidth = progress * diffWidth
            let cappedWidth = min(reducingWidth, diffWidth)

            let resizedFrameWidth = geometry.size.width - (minX > 0 ? cappedWidth : min(-cappedWidth, diffWidth))
            let negativeProgress = max(-progress, 0)

            let opacityValue = 0.4 * abs(progress)

            content(item)
                .frame(width: geometry.size.width, height: geometry.size.height)
                .frame(width: resizedFrameWidth)
                .opacity(1 - opacityValue)
                .overlay {
                    if opacityValue < 0.2 {
                        Text((item as! ImageModel).date.toString)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                            .frame(alignment: .bottom)
                            .foregroundStyle(Color.white)
                    }
                }
                .mask {
                    RoundedRectangle(cornerRadius: 12)
                }
                .offset(x: -reducingWidth)
                .offset(x: min(progress, 1) * diffWidth)
                .offset(x: negativeProgress * diffWidth)
        }
        .frame(width: 300)
    }
}
