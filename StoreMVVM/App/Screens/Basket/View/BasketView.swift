// BasketView.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Экран с корзиной
struct BasketView: View {
    // MARK: - Public Properties

    var body: some View {
        ZStack {
            BackgroundColorView()
            VStack {
                Spacer()
                Text(Constants.basketViewText)
                Spacer()
                StoreTabBarView(selection: tabBarSelection)
            }
        }
        .toolbar(.hidden)
    }

    // MARK: - Private Properties

    private let tabBarSelection: Int

    // MARK: - Initializers

    init(tabBarSelection: Int) {
        self.tabBarSelection = tabBarSelection
    }
}

struct BasketView_Previews: PreviewProvider {
    static var previews: some View {
        BasketView(tabBarSelection: 2)
    }
}
