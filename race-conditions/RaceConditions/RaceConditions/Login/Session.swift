//
//  Session.swift
//  RaceConditions
//
//  Created by Adriana Pineda on 2/4/24.
//

import Foundation
import SwiftData

@Model class Session {
    var accessToken: String
    var refreshToken: String

    init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
