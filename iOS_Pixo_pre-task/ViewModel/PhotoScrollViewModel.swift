//
//  PhotoScrollViewModel.swift
//  iOS_Pixo_pre-task
//  iOS 신입 지원자 서수영
//

import SwiftUI

@Observable
class PhotosScrollViewModel {
    var photos: [ImageModel]

    var scrollPosition: ScrollPosition = .init()
    var selectedItem: ImageModel? = nil

    var size: CGSize
    var safeArea: EdgeInsets

    init(size: CGSize, safeArea: EdgeInsets) {
        self.size = size
        self.safeArea = safeArea

        self.photos = PhotoData.shared.photos
    }

    var screenHeight: CGFloat {
        size.height + safeArea.top + safeArea.bottom
    }

    var minimisedHeight: CGFloat {
        screenHeight * 0.4
    }

    var safeAreaBottom: CGFloat {
        safeArea.bottom == 0 ? 30 : safeArea.bottom
    }

    func handlePhotoTap(photo: ImageModel) {
        selectedItem = photo
    }
}
