//
//  ParcelAppCalculatorApp.swift
//  ParcelAppCalculator
//
//  Created by Sheroz Melikov on 07/10/2025.
//

import SwiftUI
import SwiftData
@main
struct ParcelAppCalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
        .modelContainer(for:ParcelDataModel.self)
    }
}
