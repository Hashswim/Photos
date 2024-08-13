//
//  Home.swift
//  iOS_Pixo_pre-task
//  iOS 신입 지원자 서수영
//

import SwiftUI

struct Home: View {

    var size: CGSize
    var safeArea: EdgeInsets
    var sharedData = SharedData()

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 10) {
                    //상단 캐러셀
                    PhotosScrollView(size: size, safeArea: safeArea)

                    //하단 섹션
                    Library()
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Photos")
                            .font(.largeTitle.bold())
                            .foregroundStyle(Color.white)
                            .padding(safeArea)
                            .opacity(sharedData.activePage != 1 ? 0 : 1)

                        Spacer()

                        Circle()
                            .fill(.black)
                            .frame(width: 20, height: 20)
                    }
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
            .frame(width: size.width)
            .scrollDisabled(sharedData.isExpanded)
            .environment(sharedData)
        }
    }
}

#Preview {
    ContentView()
}
