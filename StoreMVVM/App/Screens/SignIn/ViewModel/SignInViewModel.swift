// SignInViewModel.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Вью модель экрана регистрации
final class SignInViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var firstNameText = ""
    @Published var lastNameText = ""
    @Published var emailText = ""
    @Published var isEmailValid = false
    @Published var isEmailAlertShown = false

    // MARK: - Public Methods

    func checkEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: emailText)
    }
}