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
        ScrollView(.vertical) {
            VStack(spacing: 10) {
                //상단 캐러셀
                PhotosScrollView(size: size, safeArea: safeArea)

                //하단 섹션
                OtherContens()
            }
        }
        .scrollDisabled(sharedData.isExpanded)
        .environment(sharedData)
    }
}

#Preview {
    ContentView()
}
