//
//  OtherContens.swift
//  iOS_Pixo_pre-task
//
//  Created by 서수영 on 8/11/24.
//

import SwiftUI

struct OtherContens: View {
    var body: some View {
        VStack(spacing: 10) {
            DummyView("Albums", .yellow)
            DummyView("People", .blue)
            DummyView("Memories", .cyan)
            DummyView("Location", .purple)
            DummyView("Screenshots", .pink)
        }
    }

    @ViewBuilder
    func DummyView(_ title: String, _ color: Color) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Button {

            } label: {
                HStack(spacing: 6) {
                    Text(title)
                        .font(.title3.bold())
                        .foregroundStyle(Color.primary)

                    Image(systemName: "chevron.right")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                }
            }

            ScrollView(.horizontal) {
                LazyHStack(spacing: 10) {
                    ForEach(1...10, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 15)
                            .fill(color)
                            .frame(width: 220, height: 120)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .safeAreaPadding(.horizontal, 15)
        .padding(.top, 15)
    }
}

#Preview {
    ContentView()
}
