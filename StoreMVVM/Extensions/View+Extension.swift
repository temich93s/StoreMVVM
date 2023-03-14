// View+Extension.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Стили View
extension View {
    // MARK: - Public Methods

    func roundedGrayStyle() -> some View {
        modifier(RoundedGrayViewModifier())
    }

    func roundedBlueStyle() -> some View {
        modifier(RoundedBlueViewModifier())
    }
}

/// Модификатор серого округленного View
struct RoundedGrayViewModifier: ViewModifier {
    // MARK: - Public Methods

    func body(content: Content) -> some View {
        content
            .frame(width: 290, height: 30)
            .multilineTextAlignment(.center)
            .background(Color("BackgroundTextFieldColor"))
            .font(Font.custom("Montserrat-Regular", size: 15))
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
            .background(Color("BackgroundButtonColor"))
            .foregroundColor(Color("ForegroundTextButtonColor"))
            .font(Font.custom("Montserrat-Bold", size: 15))
            .cornerRadius(13)
    }
}
