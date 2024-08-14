//
//  SharedData.swift
//  iOS_Pixo_pre-task
//  iOS 신입 지원자 서수영
//

import SwiftUI

@Observable
class SharedData {
    var activePage: Int = 1

    var isExpanded: Bool = false

    var mainOffset: CGFloat = 0

    var scrollOffset: CGFloat = 0

    var canPullup: Bool = false
    var canPullDown: Bool = false
    var progress: CGFloat = 0
}
