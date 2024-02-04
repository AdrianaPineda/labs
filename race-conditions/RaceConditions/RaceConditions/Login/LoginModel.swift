//
//  LoginModel.swift
//  RaceConditions
//
//  Created by Adriana Pineda on 2/4/24.
//

import Foundation

enum LoginResult: Equatable {
    static func == (lhs: LoginResult, rhs: LoginResult) -> Bool {
        switch (lhs, rhs) {
        case let (.error(lhsError), .error(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (.success, .success):
            return true
        default:
            return false
        }
    }

    var isError: Bool {
        switch self {
        case .success:
            return false
        case .error:
            return true
        }
    }

    case success
    case error(Error)
}

struct LoginModel {
    var isLoading: Bool = false
    var result: LoginResult?
}
