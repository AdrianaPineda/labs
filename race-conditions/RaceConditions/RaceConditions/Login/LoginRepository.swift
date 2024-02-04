//
//  LoginRepository.swift
//  RaceConditions
//
//  Created by Adriana Pineda on 2/4/24.
//

import Foundation

protocol LoginRepositoryProtocol {
    func login(username: String, password: String) async throws
}

class LoginRepository: LoginRepositoryProtocol {
    private let service: LoginServiceProtocol

    convenience init() {
        self.init(service: LoginService())
    }

    init(service: LoginServiceProtocol) {
        self.service = service
    }

    func login(username: String, password: String) async throws {
        do {
            print("=====> login-repository/login/\(username)")
            let response = try await service.login(username: username, password: password)
            print("login-repository/token \n\(response) <=====")
        } catch {
            throw LoginError.serverError
        }
    }
}
