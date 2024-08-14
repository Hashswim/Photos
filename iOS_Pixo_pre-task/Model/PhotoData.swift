//
//  PhotoData.swift
//  iOS_Pixo_pre-task
//
//  Created by 서수영 on 8/13/24.
//

import Foundation

final class PhotoData {
    static let shared = PhotoData()

    var photos: [ImageModel]

    private init() {
        photos = (1...46).compactMap { ImageModel(image: String(format: "IMG_%04d", $0), date: Date().random, memoryText: "") }
        photos[4].memoryText = "스키장에서"
        photos[7].memoryText = "첫 낚시"
        photos[10].memoryText = "밤에 타는 보드"
        photos[16].memoryText = "계곡에서"
        photos[24].memoryText = "물고기와 함께"
        photos[44].memoryText = "인천 강아지 카페"
    }
}
