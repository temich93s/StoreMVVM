// HeartView.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Экран с избранным товаром
struct HeartView: View {
    // MARK: - Public Properties

    var body: some View {
        ZStack {
            BackgroundColorView()
            VStack {
                Spacer()
                Text(Constants.heartViewText)
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

struct HeartView_Previews: PreviewProvider {
    static var previews: some View {
        HeartView(tabBarSelection: 1)
    }
}
