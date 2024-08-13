//
//  OtherContens.swift
//  iOS_Pixo_pre-task
//  iOS 신입 지원자 서수영
//

import SwiftUI

struct Library: View {
    var body: some View {
        VStack(spacing: 10) {
            DummyView("Recent Days" , childContentsView: RecentDayView(), height: 200)
            DummyView("Albums", childContentsView: AlbumView(), height: 180)
            DummyView("Memories", childContentsView: MemoryView(), height: 480)
        }
    }
}

#Preview {
    ContentView()
}
