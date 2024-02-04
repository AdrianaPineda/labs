//
//  ContentView.swift
//  RaceConditions
//
//  Created by Adriana Pineda on 2/4/24.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    @State private var username: String = ""
    @State private var password: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                loginForm
                if viewModel.loginModel.isLoading {
                    ProgressView()
                }
            }
        }
    }

    private var loginForm: some View {
        VStack {
            Text("Hello, please login")
            LoginCredentialsView(username: $username, password: $password)
            Button(
                "Login",
                action: {
                    Task {
                        await viewModel.login(username: self.username, password: self.password)
                    }
                }
            )
            .disabled(areCredentialsInvalid || viewModel.loginModel.isLoading)
            .alert(
                "Error logging in, please try again",
                isPresented: .constant(viewModel.loginModel.result?.isError ?? false)
            ) {}
        }
    }

    private var areCredentialsInvalid: Bool {
        return username.isEmpty || password.isEmpty
    }
}

struct LoginCredentialsView: View {
    @Binding var username: String
    @Binding var password: String

    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
        }.padding(.horizontal)
            .textFieldStyle(.roundedBorder)
    }
}

#Preview {
    return LoginView(viewModel: LoginViewModel())
}
