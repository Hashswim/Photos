//
//  MemoryView.swift
//  iOS_Pixo_pre-task
//
//  Created by 서수영 on 8/12/24.
//

import SwiftUI

struct MemoryView: View {

    var body: some View {
        GeometryReader { geometry in
            let itemWidth: CGFloat = 360
            let itemSpacing: CGFloat = 10
            let totalWidth = itemWidth + itemSpacing

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: itemSpacing) {
                    ForEach(1...10, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.blue)
                            .frame(width: itemWidth, height: 480)
                    }
                }
                .padding(.horizontal, (geometry.size.width - itemWidth) / 2)
            }
            .scrollTargetBehavior(.paging)
        }
    }
}
