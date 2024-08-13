//
//  ImageModel.swift
//  iOS_Pixo_pre-task
//
//  Created by 서수영 on 8/12/24.
//

import SwiftUI

struct ImageModel: Identifiable {
    var id: UUID = .init()
    var image: String
    var date: Date
    var memoryText: String
}

var images: [ImageModel] = (1...8).compactMap({ ImageModel(image: "Profile \($0)", date: Date(), memoryText: "\($0)번째 추억" )})

