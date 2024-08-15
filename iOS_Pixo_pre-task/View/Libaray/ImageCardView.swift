//
//  ImageCardView.swift
//  iOS_Pixo_pre-task
//
//  Created by 서수영 on 8/13/24.
//

import SwiftUI

struct ImageCardView: View {

    @Environment(\.presentationMode) var presentationMode
    let imageModel: ImageModel

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
                .padding()

                Spacer()
            }
            Text(imageModel.memoryText)
            Text(imageModel.date.description)
            Image(imageModel.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .edgesIgnoringSafeArea(.all)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
