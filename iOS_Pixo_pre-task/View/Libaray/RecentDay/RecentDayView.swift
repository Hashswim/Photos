//
//  RecentDays.swift
//  iOS_Pixo_pre-task
//  iOS 신입 지원자 서수영
//

import SwiftUI

struct RecentDayView: View {
    var body: some View {
        CoverCarousel(data: PhotoData.shared.photos.sorted(by: {
            $0.date > $1.date
        })) { image in
                Image(image.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
        }
        .animation(.snappy(duration: 0.3, extraBounce: 0), value: true)
    }
}
