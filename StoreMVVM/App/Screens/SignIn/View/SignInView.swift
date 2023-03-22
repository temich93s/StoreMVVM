// SignInView.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Экран регистрации
struct SignInView: View {
    // MARK: - Enums

    enum SignInField {
        case firstName
        case lastName
        case email
    }

    // MARK: - Public Methods

    var body: some View {
        ZStack {
            BackgroundColorView()
            VStack {
                Spacer()
                    .frame(height: 100)
                titleTextView
                Spacer()
                    .frame(height: 100)
                VStack(spacing: 30) {
                    firstNameTextFieldView
                    lastNameTextFieldView
                    emailTextFieldView
                    signInButtonView
                }
                .onSubmit {
                    switch focusedField {
                    case .firstName:
                        focusedField = .lastName
                    case .lastName:
                        focusedField = .email
                    default:
                        break
                    }
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
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        // .toolbar(.hidden)
    }

    // MARK: - Private Properties

    @EnvironmentObject private var coordinator: Coordinator

    @Environment(\.managedObjectContext) var moc

    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>

    @StateObject private var viewModel = SignInViewModel()

    @State private var isUserAlertShown: Bool = false

    @FocusState private var focusedField: SignInField?

    private var logInView: some View {
        HStack {
            Text("Already have an account?")
                .foregroundColor(Color("DarkGrayTextColor"))
            Button("Log in") {
                coordinator.push(.logIn)
            }
            Spacer()
        }
        .font(Font.custom("Montserrat-Regular", size: 10))
    }

    private var titleTextView: some View {
        Text("Sign in")
            .font(Font.custom("Montserrat-Bold", size: 26))
            .foregroundColor(Color("TitleTextColor"))
    }

    private var firstNameTextFieldView: some View {
        TextField("First name", text: $viewModel.firstNameText)
            .roundedGrayStyle()
            .focused($focusedField, equals: .firstName)
            .textContentType(.givenName)
            .submitLabel(.next)
    }

    private var lastNameTextFieldView: some View {
        TextField("Last name", text: $viewModel.lastNameText)
            .roundedGrayStyle()
            .focused($focusedField, equals: .lastName)
            .textContentType(.familyName)
            .submitLabel(.next)
    }

    private var emailTextFieldView: some View {
        TextField("Email", text: $viewModel.emailText)
            .roundedGrayStyle()
            .focused($focusedField, equals: .email)
            .textContentType(.emailAddress)
            .submitLabel(.done)
            .alert("Email incorrect", isPresented: $viewModel.isEmailAlertShown, actions: {
                Button("Ok", role: .cancel, action: {})
            })
    }

    private var signInButtonView: some View {
        Button {
            guard viewModel.checkEmail() else {
                viewModel.isEmailAlertShown = true
                return
            }
            let isUserExist = users.contains { $0.firstName == viewModel.firstNameText }
            guard !isUserExist else {
                isUserAlertShown = true
                return
            }
            let user = User(context: moc)
            user.firstName = viewModel.firstNameText
            user.lastName = viewModel.lastNameText
            user.email = viewModel.emailText
            do {
                try moc.save()
            } catch {
                print(error.localizedDescription)
            }
            coordinator.push(.home)
        } label: {
            Spacer()
            Text("Sign in")
            Spacer()
        }
        .roundedBlueStyle()
        .alert("User already exist", isPresented: $isUserAlertShown, actions: {
            Button("Ok", role: .cancel, action: {})
        })
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
