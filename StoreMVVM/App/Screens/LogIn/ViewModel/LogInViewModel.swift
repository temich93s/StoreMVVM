// LogInViewModel.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Вью модель экрана авторизации
final class LogInViewModel: LogInViewModelProtocol {
    // MARK: - Public Properties

    @Published var firstNameText = ""
    @Published var passwordText = ""
}
