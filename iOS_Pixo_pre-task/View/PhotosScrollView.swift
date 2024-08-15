//
//  ContentView.swift
//  iOS_Pixo_pre-task
//  iOS 신입 지원자 서수영
//

import SwiftUI

struct PhotosScrollView: View {

    var size: CGSize
    var safeArea: EdgeInsets

    var safeAreaBottom: CGFloat {
        (safeArea.bottom == 0 ? 30 : safeArea.bottom)
    }

    @Environment(SharedData.self) private var sharedData

    @State private var scrollPosition: ScrollPosition = .init()
    @State private var selectedItem: ImageModel? = nil

    var body: some View {
        let screenHeight = size.height + safeArea.top + safeArea.bottom
        let minimisedHeight = screenHeight * 0.6

        ScrollView(.horizontal) {
            LazyHStack(alignment: .bottom, spacing: 0) {
                GridPhotosScrollView()
                    .frame(width: size.width)
                    .id(1)

                Group {
                    StrechableView(.blue)
                        .id(2)
                    StrechableView(.yellow)
                        .id(3)
                    StrechableView(.purple)
                        .id(4)
                }
                .frame(height: screenHeight - minimisedHeight)
            }
            .scrollTargetLayout()
            .safeAreaPadding(.bottom, safeAreaBottom + 20)
        }
        .offset(y: sharedData.canPullUp ? sharedData.photosScrollOffset : 0)
        .scrollClipDisabled()
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.paging)
        .scrollPosition(id: .init(get: {
            return sharedData.activePage
        }, set: {
            if let newValue = $0 { sharedData.activePage = newValue }
        }))
        .scrollDisabled(sharedData.isExpanded)
        .frame(height: screenHeight)
        .frame(height: screenHeight - (minimisedHeight - (minimisedHeight * sharedData.progress)), alignment: .bottom)
        .overlay(alignment: .bottom) {
            CustomPagingIndicatorView {
                Task {
                    if sharedData.photosScrollOffset != 0 {
                        withAnimation(.easeInOut(duration: 0.15)) {
                            scrollPosition.scrollTo(edge: .bottom)
                        }

                        try? await Task.sleep(for: .seconds(0.13))
                    }

                    withAnimation(.easeInOut(duration: 0.25)) {
                        sharedData.progress = 0
                        sharedData.isExpanded = false
                    }
                }
            }
        }
    }

    @ViewBuilder
    func GridPhotosScrollView() -> some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 2), count: 3), spacing: 2) {
                ForEach(PhotoData.shared.photos, id: \.self) { photo in
                    Image(photo.image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 90)
                        .clipped()
                        .onTapGesture {
                            selectedItem = photo
                        }
                }
            }
            .scrollTargetLayout()
            .padding(.top, safeArea.top + safeArea.bottom + 40)
            .visualEffect { content, proxy in
                content
                    .offset(y: sharedData.progress * -(safeAreaBottom + 20))
            }
        }
        .defaultScrollAnchor(.bottom)
        .scrollDisabled(!sharedData.isExpanded)
        .scrollPosition($scrollPosition)
        .scrollClipDisabled()
        .onScrollGeometryChange(for: CGFloat.self, of: {
            $0.contentOffset.y - $0.contentSize.height + $0.containerSize.height
        }, action: { oldValue, newValue in
            sharedData.photosScrollOffset = newValue
        })
        .fullScreenCover(item: $selectedItem){ item in
            ImageCardView(imageModel: item as! ImageModel)
        }
    }

    @ViewBuilder
    func StrechableView(_ color: Color) -> some View {
        GeometryReader {
            let minY = -sharedData.mainOffset
            let size = $0.size

            Rectangle()
                .fill(color)
                .frame(width: size.width, height: size.height + (minY > 0 ? minY : 0))
                .offset(y: (minY > 0 ? -minY : 0))
        }
        .frame(width: size.width)
    }
}

#Preview {
    ContentView()
}
