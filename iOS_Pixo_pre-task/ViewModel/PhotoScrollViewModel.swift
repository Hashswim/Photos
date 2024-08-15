//
//  PhotoScrollViewModel.swift
//  iOS_Pixo_pre-task
//
//  Created by 서수영 on 8/16/24.
//

import SwiftUI

@Observable
class PhotosScrollViewModel {
    var scrollPosition: ScrollPosition = .init()
    var selectedItem: ImageModel? = nil

    var size: CGSize
    var safeArea: EdgeInsets

    init(size: CGSize, safeArea: EdgeInsets) {
        self.size = size
        self.safeArea = safeArea
    }

    var screenHeight: CGFloat {
        size.height + safeArea.top + safeArea.bottom
    }

    var minimisedHeight: CGFloat {
        screenHeight * 0.6
    }

    var safeAreaBottom: CGFloat {
        safeArea.bottom == 0 ? 30 : safeArea.bottom
    }

    func handlePhotoTap(photo: ImageModel) {
        selectedItem = photo
    }
}
