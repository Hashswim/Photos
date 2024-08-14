//
//  HomeViewModel.swift
//  iOS_Pixo_pre-task
//
//  Created by 서수영 on 8/14/24.
//

import SwiftUI

@Observable
final class HomeViewModel {
    var offset: CGFloat = 0
    var direct: Direct = .none
    private var originOffset: CGFloat = 0
    private var isCheckedOriginOffset: Bool = false

    func setOriginOffset(_ offset: CGFloat) {
        guard !isCheckedOriginOffset else { return }
        self.originOffset = offset
        self.offset = offset
        isCheckedOriginOffset = true
    }

    func setOffset(_ offset: CGFloat) {
        guard isCheckedOriginOffset else { return }
        if self.offset < offset {
            direct = .down
        } else if self.offset > offset {
            direct = .up
        } else {
            direct = .none
        }
        self.offset = offset
    }
}

enum Direct {
    case none
    case up
    case down

    var title: String {
        switch self {
            case .none: return "ㅇㅇ"
            case .up: return "위"
            case .down: return "아래"
        }
    }
}

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
