//
//  File.swift
//  SwiftDataLab
//
//  Created by Adriana Pineda on 3/28/24.
//

import Foundation
import SwiftData

enum AccountCurrency: String, Codable, CaseIterable {
    case CAD, COP, USD
}

@Model class User {
    var username: String
    var email: String

    init(username: String, email: String) {
        self.username = username
        self.email = email
    }
}

@Model class Account {
    var name: String
    var accountDescription: String
    var currency: AccountCurrency
    var users: [User]
    var transactions: [AccountTransaction]

    init(
        name: String,
        accountDescription: String,
        currency: AccountCurrency,
        users: [User],
        transactions: [AccountTransaction]
    ) {
        self.name = name
        self.accountDescription = accountDescription
        self.currency = currency
        self.users = users
        self.transactions = transactions
    }
}
