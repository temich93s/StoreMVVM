// MessageView.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Экран с чатом
struct MessageView: View {
    // MARK: - Public Properties

    var body: some View {
        ZStack {
            BackgroundColorView()
            VStack {
                Spacer()
                Text(Constants.messageViewText)
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

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(tabBarSelection: 3)
    }
}
