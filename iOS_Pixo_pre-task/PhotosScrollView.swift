//
//  ContentView.swift
//  iOS_Pixo_pre-task
//  iOS 신입 지원자 서수영
//

import SwiftUI

struct PhotosScrollView: View {

    var size: CGSize
    var safeArea: EdgeInsets

    var body: some View {
        let screenHeight = size.height + safeArea.top + safeArea.bottom
        let minimisedHeight = screenHeight * 0.4

        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                GridPhotosScrollView()
                    .frame(width: size.width)

                Group {
                    StretchableView(.blue)
                    StretchableView(.yellow)
                    StretchableView(.purple)
                }
                .frame(height: screenHeight - minimisedHeight)
            }
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.paging)
        .frame(height: screenHeight)
        .frame(height: screenHeight - minimisedHeight, alignment: .bottom)
    }

    @ViewBuilder
    func GridPhotosScrollView() -> some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 4), count: 3), spacing: 4) {
                ForEach(0...300, id: \.self) { _ in
                    Rectangle()
                        .fill(.red)
                        .frame(height: 120)
                }
            }
        }
        .defaultScrollAnchor(.bottom)
    }

    @ViewBuilder
    func StretchableView(_ color: Color) -> some View {
        GeometryReader { _ in
            Rectangle()
                .fill(color)
        }
        .frame(width: size.width)
    }
}

#Preview {
    ContentView()
}
