// LogInViewModelProtocol.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Протокол вью модели экрана авторизации
protocol LogInViewModelProtocol: ObservableObject {
    var firstNameText: String { get set }
    var passwordText: String { get set }
}
