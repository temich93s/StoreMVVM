// View+Extension.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Стили View и создание Image из Data
extension View {
    // MARK: - Public Methods

    func roundedGrayStyle() -> some View {
        modifier(RoundedGrayViewModifier())
    }

    func roundedBlueStyle() -> some View {
        modifier(RoundedBlueViewModifier())
    }

    func userImageStyle(size: CGFloat) -> some View {
        modifier(UserImageViewModifier(size: size))
    }

    func createImage(_ value: Data?) -> Image {
        let image = UIImage(data: value ?? Data()) ?? UIImage()
        return Image(uiImage: image)
    }
}

/// Модификатор серого округленного View
struct RoundedGrayViewModifier: ViewModifier {
    // MARK: - Public Methods

    func body(content: Content) -> some View {
        content
            .frame(width: 290, height: 30)
            .multilineTextAlignment(.center)
            .background(Color(NameColors.backgroundTextFieldColor))
            .font(Font.custom(NameFonts.montserratRegular, size: 15))
            .cornerRadius(15)
    }
}

/// Модификатор серого округленного View
struct RoundedBlueViewModifier: ViewModifier {
    // MARK: - Public Methods

    func body(content: Content) -> some View {
        content
            .frame(width: 290, height: 46)
            .multilineTextAlignment(.center)
            .background(Color(NameColors.backgroundButtonColor))
            .foregroundColor(Color(NameColors.foregroundTextButtonColor))
            .font(Font.custom(NameFonts.montserratBold, size: 15))
            .cornerRadius(13)
    }
}

/// Модификатор для изображения пользователя
struct UserImageViewModifier: ViewModifier {
    // MARK: - Private Properties

    private let size: CGFloat

    // MARK: - Initializers

    init(size: CGFloat) {
        self.size = size
    }

    // MARK: - Public Methods

    func body(content: Content) -> some View {
        content
            .frame(width: size, height: size)
            .cornerRadius(size / 2)
            .overlay {
                Circle()
                    .stroke(Color(NameColors.darkGrayTextColor), lineWidth: 1)
            }
            .padding(.all, 1)
    }
}
