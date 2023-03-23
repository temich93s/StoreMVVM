// LogInView.swift
// Copyright © SolovevAA. All rights reserved.

import SwiftUI

/// Экран входа
struct LogInView<ViewModel>: View where ViewModel: LogInViewModelProtocol {
    // MARK: - Enums

    enum LogInField {
        case firstName
        case password
    }

    // MARK: - Public Properties

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
    }

    // MARK: - Private Properties

    @EnvironmentObject private var coordinator: Coordinator

    @State private var isSecured: Bool = true
    @State private var isUserAlertShown: Bool = false

    @FocusState private var focusedField: LogInField?

    private var titleTextView: some View {
        Text(Constants.welcomeBackText)
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

    private var passwordView: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(Constants.passwordText, text: $viewModel.passwordText)
                } else {
                    TextField(Constants.passwordText, text: $viewModel.passwordText)
                }
            }
            Button(action: {
                isSecured.toggle()
            }, label: {
                Image(systemName: self.isSecured ? NameImages.eyeSlash : NameImages.eye)
                    .accentColor(Color(NameColors.eyeColor))
                    .padding(.trailing, 15)
            })
        }
        .roundedGrayStyle()
        .focused($focusedField, equals: .password)
        .textContentType(.emailAddress)
        .submitLabel(.done)
    }

    private var loginView: some View {
        HStack {
            Button {
                let isUserExist = users.contains { $0.firstName == viewModel.firstNameText }
                guard isUserExist else {
                    isUserAlertShown = true
                    return
                }
                coordinator.push(.home)
            } label: {
                Spacer()
                Text(Constants.loginText)
                Spacer()
            }
        }
        .roundedBlueStyle()
        .alert(Constants.userNotExistText, isPresented: $isUserAlertShown, actions: {
            Button(Constants.okText, role: .cancel, action: {})
        })
    }
}
