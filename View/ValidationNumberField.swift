//
//  ValidationNumberField.swift
//  ParcelAppCalculator
//
//  Created by Sheroz Melikov on 16/10/2025.
//

import SwiftUI

struct ValidationNumberField: View {
    let label: String
    @Binding var value: String

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Label(label, systemImage: "")
                .labelStyle(.titleOnly)
                .frame(width: 120, alignment: .trailing)

            TextField("Enter \(label)", text: $value)
                .onChange(of: value) { oldValue, newValue in
                    value = checkData(newValue: newValue)
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .border(Color.black, width: 2)
                .keyboardType(.decimalPad)
        }
    }
    
    func checkData(newValue: String) -> String {
        var result = ""
        var decimalFound = false

        for character in newValue {
            if character.isNumber {
                // Prevent multiple leading zeros before decimal
                if result == "0" && character == "0" && !decimalFound {
                    continue
                }
                result.append(character)
            } else if character == "." {
                if !decimalFound {
                    decimalFound = true
                    if result.isEmpty {
                        result = "0"
                    }
                    result.append(".")
                }
            }
            // Ignore all other characters
        }

        // Remove extra leading zeros (e.g., 000123)
        if !decimalFound && result.count > 1 && result.first == "0" {
            while result.first == "0" && result.count > 1 {
                result.removeFirst()
            }
        }

        return result
    }
}

