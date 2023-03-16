// LogInView.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Экран входа
struct LogInView: View {
    // MARK: - Enums

    enum LogInField {
        case firstName
        case password
    }

    // MARK: - Public Methods

    var body: some View {
        ZStack {
            Color("BackgroundMainViewColor")
                .ignoresSafeArea()
            VStack {
                Spacer()
                    .frame(height: 100)
                titleTextView
                Spacer()
                    .frame(height: 100)
                firstNameTextFieldView
                Spacer()
                    .frame(height: 30)
                passwordView
                Spacer()
                    .frame(height: 100)
                    .border(.green)
                loginView
                Spacer()
            }
            .frame(width: 290)
            .onSubmit {
                switch focusedField {
                case .firstName:
                    focusedField = .password
                default:
                    break
                }
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        // .toolbar(.hidden)
    }

    // MARK: - Private Properties

    @EnvironmentObject private var coordinator: Coordinator

    @State private var firstNameText = ""
    @State private var passwordText = ""
    @State private var isSecured: Bool = true

    @FocusState private var focusedField: LogInField?

    private var titleTextView: some View {
        Text("Welcome back")
            .font(Font.custom("Montserrat-Bold", size: 26))
    }

    private var firstNameTextFieldView: some View {
        TextField("First name", text: $firstNameText)
            .roundedGrayStyle()
            .focused($focusedField, equals: .firstName)
            .textContentType(.givenName)
            .submitLabel(.next)
    }

    private var passwordView: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField("Password", text: $passwordText)
                } else {
                    TextField("Password", text: $passwordText)
                }
            }
            Button(action: {
                isSecured.toggle()
            }, label: {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(Color("EyeColor"))
                    .padding(.trailing, 15)
            })
        }
        .roundedGrayStyle()
        .focused($focusedField, equals: .password)
        .textContentType(.emailAddress)
        .submitLabel(.done)
    }

    private var loginView: some View {
        Button("Login") {}
            .roundedBlueStyle()
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
