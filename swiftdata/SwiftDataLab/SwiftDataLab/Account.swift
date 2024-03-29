//
//  File.swift
//  SwiftDataLab
//
//  Created by Adriana Pineda on 3/28/24.
//

import Foundation
import SwiftData

enum AccountCurrency: String, Codable, CaseIterable {
    case USD, CAD
}

@Model class Account {
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
