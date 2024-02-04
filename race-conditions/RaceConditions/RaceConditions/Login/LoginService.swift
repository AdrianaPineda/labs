//
//  LoginService.swift
//  RaceConditions
//
//  Created by Adriana Pineda on 2/4/24.
//

import Alamofire
import Foundation

struct LoginResponse: Decodable {
    let accessToken: String
    let refreshToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access"
        case refreshToken = "refresh"
    }
}

protocol LoginServiceProtocol {
    func login(username: String, password: String) async throws -> LoginResponse
}

struct LoginPayload: Encodable, Hashable {
    let username: String
    let password: String
}

// actor keyword guarantees thread-safety
// Actors have a built-in synchronization mechanism that ensures only one task at a time can access the actor's methods, making the code inherently thread-safe
// https://medium.com/@gauravborole/swift-actor-new-concurrency-feature-2af6fc5d9ed4
actor LoginService: LoginServiceProtocol {
    private let loginPath = "http://localhost:8000/api/token/"
    private var cachedLoginRequest: (payload: LoginPayload, request: DataRequest)?

    func login(username: String, password: String) async throws -> LoginResponse {
        print("login-service/login")

        let payload = LoginPayload(username: username, password: password)

        // Guarantee no duplicate requests are perform in parallel
        let loginRequest: DataRequest
        if let cachedLoginRequest, cachedLoginRequest.payload == payload {
            loginRequest = cachedLoginRequest.request
        } else {
            cachedLoginRequest?.request.cancel()
            loginRequest = sendRequest(payload: payload)
        }

        cachedLoginRequest = (payload, loginRequest)
        return try await login(using: loginRequest)
    }

    private func sendRequest(payload: LoginPayload) -> DataRequest {
        print("login-service/request")
        return AF.request(
            loginPath,
            method: .post,
            parameters: payload,
            encoder: JSONParameterEncoder.default
        )
    }

    private func login(using request: DataRequest) async throws -> LoginResponse {
        return try await withCheckedThrowingContinuation { continuation in
            request.responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                case let .success(loginResponse):
                    continuation.resume(returning: loginResponse)
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
