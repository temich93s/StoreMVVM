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
        // .toolbar(.hidden)
    }

    // MARK: - Private Properties

    @EnvironmentObject private var coordinator: Coordinator

    @Environment(\.managedObjectContext) var moc

    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>

    @StateObject private var viewModel = LogInViewModel()

    @State private var isSecured: Bool = true
    @State private var isUserAlertShown: Bool = false

    @FocusState private var focusedField: LogInField?

    private var titleTextView: some View {
        Text("Welcome back")
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

    private var passwordView: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField("Password", text: $viewModel.passwordText)
                } else {
                    TextField("Password", text: $viewModel.passwordText)
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
                Text("Login")
                Spacer()
            }
        }
        .roundedBlueStyle()
        .alert("User not exist", isPresented: $isUserAlertShown, actions: {
            Button("Ok", role: .cancel, action: {})
        })
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
