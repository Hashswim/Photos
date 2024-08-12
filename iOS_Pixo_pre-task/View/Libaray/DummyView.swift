//
//  DummyView.swift
//  iOS_Pixo_pre-task
//
//  Created by 서수영 on 8/12/24.
//

import SwiftUI

struct DummyView<ChildContentsView: View>: View {
    let title: LocalizedStringKey
    let height: Double
    @ViewBuilder let childContentsView: ChildContentsView

    init(_ title: LocalizedStringKey, childContentsView: ChildContentsView, height: Double) {
        self.title = title
        self.childContentsView = childContentsView
        self.height = height
    }

    var body: some View {
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
            childContentsView
                .frame(height: height)
        }
        .scrollIndicators(.hidden)
        .safeAreaPadding(.horizontal, 15)
        .padding(.top, 15)
    }
}
