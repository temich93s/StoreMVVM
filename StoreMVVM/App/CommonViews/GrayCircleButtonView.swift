// GrayCircleButtonView.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Серая круглая кнопка с изображением внутри
struct GrayCircleButtonView: View {
    // MARK: - Public Properties

    var body: some View {
        Button {
            action()
        } label: {
            Image(imageName)
                .resizable()
                .padding(.all, diameter / 4)
                .background(
                    RoundedRectangle(cornerRadius: diameter / 2)
                        .foregroundColor(Color(NameColors.backgroundCategoryColor))
                )
                .frame(width: diameter, height: diameter)
        }
    }

    // MARK: - Private Properties

    private let diameter: CGFloat
    private let imageName: String
    private let action: () -> ()

    // MARK: - Initializers

    init(diameter: CGFloat, imageName: String, action: @escaping () -> ()) {
        self.diameter = diameter
        self.imageName = imageName
        self.action = action
    }
}
