//
//  ImageCardView.swift
//  iOS_Pixo_pre-task
//
//  Created by 서수영 on 8/13/24.
//

import SwiftUI

struct ImageCardView: View {

    let imageModel: ImageModel

    var body: some View {
        VStack {
            Text(imageModel.memoryText)
            Text(imageModel.date.description)
            Image(imageModel.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
//                .clipShape(.rect(cornerRadius: 15))
                .edgesIgnoringSafeArea(.all)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
