// SignInView.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

// Экран регистрации
struct SignInView: View {
    // MARK: - Public Methods

    var body: some View {
        ZStack {
            Color("BackgroundMainViewColor")
                .ignoresSafeArea()
            VStack {
                Spacer()
                    .frame(height: 100)
                    .border(.green)
                Text("Sign in")
                    .font(Font.custom("Montserrat-Bold", size: 26))
                Spacer()
                    .frame(height: 100)
                VStack(spacing: 30) {
                    TextField("First name", text: $firstNameText)
                        .roundedGrayStyle()
                    TextField("Last name", text: $firstNameText)
                        .roundedGrayStyle()
                    TextField("Email", text: $firstNameText)
                        .roundedGrayStyle()
                    Button("Sign in") {}
                        .roundedBlueStyle()
                }
                VStack(spacing: 50) {
                    logInView
                    socialNetworkAccountView(imageName: "Google", socialNetworkName: "Sign in with Google")
                    socialNetworkAccountView(imageName: "Apple", socialNetworkName: "Sign in with Apple")
                }
                .frame(width: 290)
                Spacer()
            }
        }
    }

    // MARK: - Private Properties

    @State private var firstNameText = ""

    private var logInView: some View {
        HStack {
            Text("Already have an account?")
                .foregroundColor(Color("DarkGrayTextColor"))
            Button("Log in") {}
            Spacer()
        }
        .font(Font.custom("Montserrat-Regular", size: 10))
    }

    // MARK: - Private Methods

    private func socialNetworkAccountView(imageName: String, socialNetworkName: String) -> some View {
        HStack {
            Spacer()
                .frame(width: 60)
            Image(imageName)
                .frame(width: 24, height: 24)
            Button(socialNetworkName, action: {})
                .foregroundColor(Color("BlackTextColor"))
                .font(Font.custom("Montserrat-Regular", size: 15))
            Spacer()
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
