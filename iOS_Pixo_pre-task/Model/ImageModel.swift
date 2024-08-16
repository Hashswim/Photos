//
//  ImageModel.swift
//  iOS_Pixo_pre-task
//  iOS 신입 지원자 서수영
//

import SwiftUI

struct ImageModel: Identifiable, Hashable {
    var id: UUID = .init()
    var image: String
    var date: Date
    var memoryText: String

    var album: AlbumType?
}
