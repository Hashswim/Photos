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

        photos[7].album = .summer
        photos[9].album = .summer
        photos[15].album = .summer
        photos[16].album = .summer

        photos[4].album = .winter
        photos[5].album = .winter
        photos[29].album = .winter
        photos[44].album = .winter

        photos[8].album = .travel
        photos[19].album = .travel

        photos[30].album = .mySpecial
        photos[31].album = .mySpecial
        photos[35].album = .mySpecial
    }
}

enum AlbumType: CaseIterable, Identifiable {
    case summer, winter, travel, mySpecial

    var id: Self {
        return self
    }

    var name: String {
        switch self {
        case .summer:
            "여름"
        case .winter:
            "겨울"
        case .travel:
            "여행"
        case .mySpecial:
            "나만의 앨범"
        }
    }
}
