//
//  AccountTransaction.swift
//  SwiftDataLab
//
//  Created by Adriana Pineda on 3/28/24.
//

import Foundation
import SwiftData

enum SettlingState: Codable {
    case pending, mine, split, owe, owned
}

@Model class AccountTransaction {
    var date: Date
    var amount: Double
    var txDescription: String
    var settlingState: SettlingState

    init(date: Date, amount: Double, txDescription: String, settlingState: SettlingState) {
        self.date = date
        self.amount = amount
        self.txDescription = txDescription
        self.settlingState = settlingState
    }
}
