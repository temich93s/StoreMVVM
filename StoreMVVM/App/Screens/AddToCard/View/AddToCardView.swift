// AddToCardView.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Экран с привязкой карты
struct AddToCardView: View {
    // MARK: - Public Properties

    var body: some View {
        ZStack {
            BackgroundColorView()
            VStack {
                Spacer()
                Text(Constants.addToCardViewText)
                Spacer()
                StoreTabBarView(selection: tabBarSelection)
            }
        }
    }

    // MARK: - Private Properties

    private let tabBarSelection: Int

    // MARK: - Initializers

    init(tabBarSelection: Int) {
        self.tabBarSelection = tabBarSelection
    }
}

struct AddToCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddToCardView(tabBarSelection: 0)
    }
}
