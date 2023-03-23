// SignInViewModelProtocol.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Протокол вью модели экрана регистрации
protocol SignInViewModelProtocol: ObservableObject {
    var firstNameText: String { get set }
    var lastNameText: String { get set }
    var emailText: String { get set }
    var isEmailValid: Bool { get set }
    var isEmailAlertShown: Bool { get set }

    func checkEmail() -> Bool
}
