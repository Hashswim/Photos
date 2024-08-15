//
//  Home.swift
//  iOS_Pixo_pre-task
//  iOS 신입 지원자 서수영
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel: HomeViewModel

    init(size: CGSize, safeArea: EdgeInsets) {
        _viewModel = State(initialValue: HomeViewModel(size: size, safeArea: safeArea))
    }

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 10) {
                PhotosScrollView(size: viewModel.size, safeArea: viewModel.safeArea)

                Library()
                    .padding(.top, -30)
                    .offset(y: viewModel.sharedData.progress * 30)
            }
            .offset(y: viewModel.sharedData.canPullDown ? 0 : viewModel.sharedData.mainOffset < 0 ? -viewModel.sharedData.mainOffset : 0)
            .offset(y: viewModel.sharedData.mainOffset < 0 ? viewModel.sharedData.mainOffset : 0)
        }
        .scrollBounceBehavior(.basedOnSize)
        .onScrollGeometryChange(for: CGFloat.self, of: {
            $0.contentOffset.y
        }, action: viewModel.handleScrollChange)
        .scrollDisabled(viewModel.sharedData.isExpanded)
        .environment(viewModel.sharedData)
        .gesture(
            CustomGesture(isEnabled: viewModel.sharedData.activePage == 1) { gesture in
                viewModel.handleGesture(gesture: gesture)
            }
        )
        .background(.gray.opacity(0.05))
        .overlay(alignment: .top) {
            HStack {
                Text("Photos")
                    .font(.largeTitle.bold())
                    .padding(viewModel.safeArea)
                    .opacity(viewModel.sharedData.activePage != 1 ? 0 : 1)

                Spacer()

                Circle()
                    .fill(.black)
                    .frame(width: 20, height: 20)
            }
            .padding()
            .frame(height: viewModel.size.height * 0.15)
        }
    }
}

#Preview {
    ContentView()
}

