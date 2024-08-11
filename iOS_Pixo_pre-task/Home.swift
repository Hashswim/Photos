//
//  Home.swift
//  iOS_Pixo_pre-task
//  iOS 신입 지원자 서수영
//

import SwiftUI

struct Home: View {

    var size: CGSize
    var safeArea: EdgeInsets

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 10) {
                PhotosScrollView(size: size, safeArea: safeArea)
            }
        }
    }
}

#Preview {
    ContentView()
}
