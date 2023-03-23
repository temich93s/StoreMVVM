// Builder.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Сборщик экранов
final class Builder {
    // MARK: - Public Methods

    func makeLogInView() -> some View {
        let viewModel = LogInViewModel()
        let view = LogInView(viewModel: viewModel)
        return view
    }

    func makeSignInView() -> some View {
        let viewModel = SignInViewModel()
        let view = SignInView(viewModel: viewModel)
        return view
    }

    func makeHomeDetailView(tabBarSelection: Int) -> some View {
        let networkService = StoreNetworkService()
        let viewModel = HomeDetailViewModel(networkService: networkService)
        let view = HomeDetailView(tabBarSelection: tabBarSelection, viewModel: viewModel)
        return view
    }

    func makeAddToCardView(tabBarSelection: Int) -> some View {
        AddToCardView(tabBarSelection: tabBarSelection)
    }

    func makeHomeView(tabBarSelection: Int) -> some View {
        let networkService = StoreNetworkService()
        let viewModel = HomeViewModel(networkService: networkService)
        let view = HomeView(tabBarSelection: tabBarSelection, viewModel: viewModel)
        return view
    }

    func makeHeartView(tabBarSelection: Int) -> some View {
        HeartView(tabBarSelection: tabBarSelection)
    }

    func makeBasketView(tabBarSelection: Int) -> some View {
        BasketView(tabBarSelection: tabBarSelection)
    }

    func makeMessageView(tabBarSelection: Int) -> some View {
        MessageView(tabBarSelection: tabBarSelection)
    }

    func makeProfileView(tabBarSelection: Int) -> some View {
        let viewModel = ProfileViewModel()
        let view = ProfileView(tabBarSelection: tabBarSelection, viewModel: viewModel)
        return view
    }
}
