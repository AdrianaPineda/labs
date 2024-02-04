//
//  Item.swift
//  RaceConditions
//
//  Created by Adriana Pineda on 2/4/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
