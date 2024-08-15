//
//  HomeViewModel.swift
//  iOS_Pixo_pre-task
//  iOS 신입 지원자 서수영
//

import SwiftUI

@Observable
class HomeViewModel: ObservableObject {
    var sharedData = SharedData()
    var isMovingDown: Bool = false
    var translationValue: CGFloat = 0

    private var minimisedHeight: CGFloat {
        (size.height + safeArea.top + safeArea.bottom) * 0.4
    }

    var size: CGSize
    var safeArea: EdgeInsets

    init(size: CGSize, safeArea: EdgeInsets) {
        self.size = size
        self.safeArea = safeArea
    }

    func handleScrollChange(oldValue: CGFloat, newValue: CGFloat) {
        sharedData.mainOffset = newValue
    }

    func handleTranslationChange(newValue: CGFloat) {
        isMovingDown = translationValue < newValue
        translationValue = newValue
    }

    func handleGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: gesture.view).y
        let isScrolling = gesture.state == .began || gesture.state == .changed

        let mainOffset = sharedData.mainOffset
        let photosScrollOffset = sharedData.photosScrollOffset

        if gesture.state == .began {
            sharedData.canPullDown = translation > 0 && (mainOffset >= 0 && mainOffset < 50)
            sharedData.canPullUp = translation < 0 && (photosScrollOffset >= 0 && photosScrollOffset < 50)
        }

        if isScrolling {
            if sharedData.canPullDown && !sharedData.isExpanded {
                let progress = max(min(translation / minimisedHeight, 1), 0)
                sharedData.progress = progress
            }

            if sharedData.canPullUp && sharedData.isExpanded {
                let progress = max(min(-translation / minimisedHeight, 1), 0)
                sharedData.progress = 1 - progress
            }

            handleTranslationChange(newValue: translation)
        } else {
            withAnimation(.smooth(duration: 0.35, extraBounce: 0)) {
                if sharedData.canPullDown && !sharedData.isExpanded {
                    if translation > 0 && isMovingDown {
                        sharedData.isExpanded = true
                        sharedData.progress = 1
                    } else {
                        sharedData.progress = 0
                    }
                }

                if sharedData.canPullUp && sharedData.isExpanded {
                    if translation < 0 && !isMovingDown {
                        sharedData.isExpanded = false
                        sharedData.progress = 0
                    } else {
                        sharedData.progress = 1
                    }
                }
            }
        }
    }
}
