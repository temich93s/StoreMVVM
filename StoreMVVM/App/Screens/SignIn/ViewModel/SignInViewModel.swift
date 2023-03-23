// SignInViewModel.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Вью модель экрана регистрации
final class SignInViewModel: SignInViewModelProtocol {
    // MARK: - Public Properties

    @Published var firstNameText = ""
    @Published var lastNameText = ""
    @Published var emailText = ""
    @Published var isEmailValid = false
    @Published var isEmailAlertShown = false

    // MARK: - Public Methods

    func checkEmail() -> Bool {
        let emailFormat = Constants.emailFormatText
        let emailPredicate = NSPredicate(format: Constants.emailPredicateText, emailFormat)
        return emailPredicate.evaluate(with: emailText)
    }
}
