//
//  ImageCardView.swift
//  iOS_Pixo_pre-task
//  iOS 신입 지원자 서수영
//

import SwiftUI

struct ImageCardView: View {
    @Environment(\.presentationMode) var presentationMode
    let imageModel: ImageModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }

                Spacer()
            }

            if imageModel.memoryText != "" {
                Text(imageModel.memoryText)
                    .font(.title2.bold())
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                    )
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
            }

            Text(imageModel.date, style: .date)
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.horizontal)
                .padding(.vertical, 4)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.systemGray5))
                )

            Image(imageModel.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                .padding(.top, 8)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}
