// SignInView.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Экран регистрации
struct SignInView<ViewModel>: View where ViewModel: SignInViewModelProtocol {
    // MARK: - Enums

    enum SignInField {
        case firstName
        case lastName
        case email
    }

    // MARK: - Public Methods

    @Environment(\.managedObjectContext) var moc

    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>

    @StateObject var viewModel: ViewModel

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
                    socialNetworkAccountView(
                        imageName: Constants.GoogleText,
                        socialNetworkName: Constants.signInWithGoogleText
                    )
                    socialNetworkAccountView(
                        imageName: Constants.appleText,
                        socialNetworkName: Constants.signInWithGoogleText
                    )
                }
                .frame(width: 290)
                Spacer()
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }

    // MARK: - Private Properties

    @EnvironmentObject private var coordinator: Coordinator

    @State private var isUserAlertShown: Bool = false

    @FocusState private var focusedField: SignInField?

    private var logInView: some View {
        HStack {
            Text(Constants.haveAccountText)
                .foregroundColor(Color(NameColors.darkGrayTextColor))
            Button(Constants.logInText) {
                coordinator.push(.logIn)
            }
            Spacer()
        }
        .font(Font.custom(NameFonts.montserratRegular, size: 10))
    }

    private var titleTextView: some View {
        Text(Constants.signInText)
            .font(Font.custom(NameFonts.montserratBold, size: 26))
            .foregroundColor(Color(NameColors.titleTextColor))
    }

    private var firstNameTextFieldView: some View {
        TextField(Constants.firstNameText, text: $viewModel.firstNameText)
            .roundedGrayStyle()
            .focused($focusedField, equals: .firstName)
            .textContentType(.givenName)
            .submitLabel(.next)
    }

    private var lastNameTextFieldView: some View {
        TextField(Constants.lastNameText, text: $viewModel.lastNameText)
            .roundedGrayStyle()
            .focused($focusedField, equals: .lastName)
            .textContentType(.familyName)
            .submitLabel(.next)
    }

    private var emailTextFieldView: some View {
        TextField(Constants.emailText, text: $viewModel.emailText)
            .roundedGrayStyle()
            .focused($focusedField, equals: .email)
            .textContentType(.emailAddress)
            .submitLabel(.done)
            .alert(Constants.emailIncorrectText, isPresented: $viewModel.isEmailAlertShown, actions: {
                Button(Constants.okText, role: .cancel, action: {})
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
                print(error)
            }
            coordinator.push(.home)
        } label: {
            Spacer()
            Text(Constants.signInText)
            Spacer()
        }
        .roundedBlueStyle()
        .alert(Constants.userAlreadyExistText, isPresented: $isUserAlertShown, actions: {
            Button(Constants.okText, role: .cancel, action: {})
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
                .foregroundColor(Color(NameColors.blackTextColor))
                .font(Font.custom(NameFonts.montserratRegular, size: 15))
            Spacer()
        }
    }
}
