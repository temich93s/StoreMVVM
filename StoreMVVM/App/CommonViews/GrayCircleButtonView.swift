// GrayCircleButtonView.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Кнопка плюс
struct GrayCircleButtonView: View {
    let diameter: CGFloat
    let imageName: String
    let action: () -> ()

    var body: some View {
        Button {
            action()
        } label: {
            Image(imageName)
                .resizable()
                .padding(.all, diameter / 4)
                .background(
                    RoundedRectangle(cornerRadius: diameter / 2)
                        .foregroundColor(Color("BackgroundCategoryColor"))
                )
                .frame(width: diameter, height: diameter)
        }
    }
}
