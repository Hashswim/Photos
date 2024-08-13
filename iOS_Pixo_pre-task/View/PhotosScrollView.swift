//
//  ContentView.swift
//  iOS_Pixo_pre-task
//  iOS 신입 지원자 서수영
//

import SwiftUI

struct PhotosScrollView: View {

    var size: CGSize
    var safeArea: EdgeInsets
    @Environment(SharedData.self) private var sharedData

    var body: some View {
        let screenHeight = size.height + safeArea.top + safeArea.bottom
        let minimisedHeight = screenHeight * 0.6

        ScrollView(.horizontal) {
            LazyHStack(alignment: .bottom, spacing: 0) {
                GridPhotosScrollView()
                    .frame(width: size.width)
                    .id(1)

                Group {
                    StretchableView(.blue)
                        .id(2)
                    StretchableView(.yellow)
                        .id(3)
                    StretchableView(.purple)
                        .id(4)
                }
                .frame(height: screenHeight - minimisedHeight)
            }
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.paging)
        .safeAreaPadding(.bottom, 15)
        .scrollPosition(id: .init(get: {
            return sharedData.activePage
        }, set: {
            if let newValue = $0 { sharedData.activePage = newValue }
        }))
        .scrollDisabled(sharedData.isExpanded)
        .frame(height: screenHeight)
        .frame(height: screenHeight - minimisedHeight, alignment: .bottom)
        .overlay(alignment: .bottom) {
            CustomPagingIndicatorView()
        }
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
        .scrollDisabled(!sharedData.isExpanded)
    }

    @ViewBuilder
    func StretchableView(_ color: Color) -> some View {
        GeometryReader {
            let minY = $0.frame(in: .scrollView(axis: .vertical)).minY
            let size = $0.size

            Rectangle()
                .fill(color)
                .frame(width: size.width, height: size.height + (minY > 0 ? minY : 0))
                .offset(y: (minY > 0 ? -minY : 0 ))
        }
        .frame(width: size.width)
    }
}

#Preview {
    ContentView()
}
