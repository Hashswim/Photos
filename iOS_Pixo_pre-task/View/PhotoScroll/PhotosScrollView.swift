//
//  ContentView.swift
//  iOS_Pixo_pre-task
//  iOS 신입 지원자 서수영
//

import SwiftUI

struct PhotosScrollView: View {
    @State private var viewModel: PhotosScrollViewModel
    @Environment(SharedData.self) private var sharedData

    @State private var selectedItem: ImageModel? = nil

    init(size: CGSize, safeArea: EdgeInsets) {
        _viewModel = State(initialValue: PhotosScrollViewModel(size: size, safeArea: safeArea))
    }

    var body: some View {
        let screenHeight = viewModel.size.height + viewModel.safeArea.top + viewModel.safeAreaBottom
        let minimisedHeight = screenHeight * 0.4

        ScrollView(.horizontal) {
            LazyHStack(alignment: .bottom, spacing: 0) {
                GridPhotosScrollView()
                    .frame(width: viewModel.size.width)
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
            .safeAreaPadding(.bottom, viewModel.safeAreaBottom + 20)
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
                            viewModel.scrollPosition.scrollTo(edge: .bottom)
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
                ForEach(0...29, id: \.self) { i in
                    Image(PhotoData.shared.photos[i].image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .clipped()
                        .aspectRatio(1, contentMode: .fit)
                        .onTapGesture {
                            selectedItem = PhotoData.shared.photos[i]
                        }
                }
            }
            .scrollTargetLayout()
            .padding(.top, viewModel.safeArea.top + viewModel.safeArea.bottom + 40)
            .visualEffect { content, proxy in
                content
                    .offset(y: sharedData.progress * -(viewModel.safeAreaBottom + 20))
            }
        }
        .defaultScrollAnchor(.bottom)
        .scrollDisabled(!sharedData.isExpanded)
        .scrollPosition($viewModel.scrollPosition)
        .scrollClipDisabled()
        .onScrollGeometryChange(for: CGFloat.self, of: {
            $0.contentOffset.y - $0.contentSize.height + $0.containerSize.height
        }, action: { oldValue, newValue in
            sharedData.photosScrollOffset = newValue
        })
        .fullScreenCover(item: $selectedItem){ item in
            ImageCardView(imageModel: item)
        }
    }

    @ViewBuilder
    private func StrechableView(_ color: Color) -> some View {
        GeometryReader { geometry in
            let minY = -sharedData.mainOffset
            let size = geometry.size

            Rectangle()
                .fill(color)
                .frame(width: size.width, height: size.height + (minY > 0 ? minY : 0))
                .offset(y: (minY > 0 ? -minY : 0))
        }
        .frame(width: viewModel.size.width)
    }
}
