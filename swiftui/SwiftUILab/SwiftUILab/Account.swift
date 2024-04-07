//
//  Account.swift
//  SwiftUILab
//
//  Created by Adriana Pineda on 4/7/24.
//

import Foundation

enum AccountCurrency: String, CaseIterable {
    case USD, CAD
}

class Account: Identifiable {
    var name: String
    var accountDescription: String
    var currency: AccountCurrency

    init(
        name: String,
        accountDescription: String,
        currency: AccountCurrency
    ) {
        self.name = name
        self.accountDescription = accountDescription
        self.currency = currency
    }
}
