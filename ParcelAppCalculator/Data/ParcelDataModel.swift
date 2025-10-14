//
//  ParcelDataModel.swift
//  ParcelAppCalculator
//
//  Created by Sheroz Melikov on 14/10/2025.
//

import Foundation
import SwiftData

@Model

class ParcelDataModel: Identifiable{
        var weight : String
        var volume : String
        var cost : String
        var postDate : Date
    init(weight: String, volume: String, cost: String, postDate: Date) {
        self.weight = weight
        self.volume = volume
        self.cost = cost
        self.postDate = postDate
    }

                        
}
