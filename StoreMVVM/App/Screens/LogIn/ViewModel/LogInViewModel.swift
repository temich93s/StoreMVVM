// LogInViewModel.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Вью модель экрана регистрации
final class LogInViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var firstNameText = ""
    @Published var passwordText = ""
}
