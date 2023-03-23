// BackgroundColorView.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Фон основного меню
struct BackgroundColorView: View {
    // MARK: - Public Properties

    var body: some View {
        Color(NameColors.backgroundMainViewColor)
            .ignoresSafeArea()
    }
}

struct BackgroundColorView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundColorView()
    }
}
