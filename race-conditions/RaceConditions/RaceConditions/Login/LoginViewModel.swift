//
//  LoginViewModel.swift
//  RaceConditions
//
//  Created by Adriana Pineda on 2/4/24.
//

import Foundation

enum LoginError: Error {
    case storageError
    case serverError
    case internalError
}

protocol LoginViewModelProtocol {
    func login(username: String, password: String) async
}

class LoginViewModel: LoginViewModelProtocol, ObservableObject {
    @Published var loginModel = LoginModel()
    private let repository: LoginRepositoryProtocol

    convenience init() {
        self.init(repository: LoginRepository())
    }

    init(repository: LoginRepositoryProtocol) {
        self.repository = repository
    }

    @MainActor func login(username: String, password: String) async {
        loginModel.isLoading = true
        loginModel.result = nil

        defer {
            loginModel.isLoading = false
        }

        do {
            try await repository.login(username: username, password: password)
            loginModel.result = .success
        } catch {
            loginModel.result = .error(error)
        }
    }
}
