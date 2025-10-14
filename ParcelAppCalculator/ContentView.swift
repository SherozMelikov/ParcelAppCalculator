import SwiftUI

struct ContentView: View {
    @State private var weight: String = ""
    @State private var width: String = ""
    @State private var height: String = ""
    @State private var depth: String = "" // Not used, but included in the form
    @State private var cost: String = ""
    @State private var errorMessage: String = ""
    
    var isdisabled: Bool {
        weight.isEmpty || depth.isEmpty || width.isEmpty || height.isEmpty
    }
    @State private var useAdvancedPricing: Bool = false

    var body: some View {
        VStack {
            Text("📦 Parcel Calculator")
                .font(.title)
                .padding()
            
            Toggle(isOn:$useAdvancedPricing){
                Text("Use Advanced Pricing ")
            }
            .padding(.horizontal)
            .toggleStyle(SwitchToggleStyle(tint: .green))
            
            // Weight Input
            HStack(alignment: .center, spacing: 10) {
                Label("Weight (kg): ", systemImage: "")
                    .labelStyle(.titleOnly)
                    .frame(width: 120, alignment: .trailing)
                TextField("Enter weight: ", text: $weight)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.black, width: 2)
                    .keyboardType(.decimalPad)
            }
            
            // Height Input
            HStack(alignment: .center, spacing: 10) {
                Label("Height (cm): ", systemImage: "")
                    .labelStyle(.titleOnly)
                    .frame(width: 120, alignment: .trailing)
                TextField("Enter height: ", text: $height)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.black, width: 2)
                    .keyboardType(.decimalPad)
            }
            
            // Width Input
            HStack(alignment: .center, spacing: 10) {
                Label("Width (cm): ", systemImage: "")
                    .labelStyle(.titleOnly)
                    .frame(width: 120, alignment: .trailing)
                TextField("Enter width: ", text: $width)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.black, width: 2)
                    .keyboardType(.decimalPad)
            }
            
            
            
            // Depth Input
            HStack(alignment: .center, spacing: 10) {
                Label("Depth (cm): ", systemImage: "")
                    .labelStyle(.titleOnly)
                    .frame(width: 120, alignment: .trailing)
                TextField("Enter depth: ", text: $depth)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.black, width: 2)
                    .keyboardType(.decimalPad)
            }
            
            Button("Calculate Cost") {
                calculateCost()
            }
            .disabled(isdisabled)
            .background(isdisabled ? Color.gray : Color.blue)
            .padding()
            .foregroundColor(.white)
            .cornerRadius(8)
            
            // Display Error Message if any
            if !errorMessage.isEmpty {
                Text(errorMessage).foregroundColor(.red)
            }
            
            // Display Cost if available
            if !cost.isEmpty {
                if let costValue = Double(cost), costValue > 0.00 {
                    Text("Total cost is £\(cost)")
                } else {
                    Text(cost).foregroundColor(.red)
                }
            }
        }
        .padding()
    }

    private func calculateCost() {
        cost = ""
        errorMessage = ""
        
        // Validate input values
        guard let weightValue = Double(weight), weightValue > 0,
              let widthValue = Double(width), widthValue > 0,
              let lengthValue = Double(depth),lengthValue > 0,
              let heightValue = Double(height), heightValue > 0 else {
            errorMessage = "Please enter valid numbers greater than 0."
            return
        }

        if useAdvancedPricing {
            if weightValue > 30 {
                errorMessage = "Error: Max weight is 30kg."
                return
            }
            if max(lengthValue,widthValue,heightValue) > 150{
                errorMessage = "Error: Max dimensions is 150cm."
                return
            }
            let totalCost = calculateAdvancedCost(weight: weightValue, length: lengthValue, width: widthValue, height: heightValue)
            cost = String(format: "%.2f", totalCost)
        } else {
            let totalCost = calculateBasicCost(weight: weightValue, length: lengthValue, width: widthValue, height: heightValue)

            cost = String(format: "%.2f",totalCost)
        }
    }

    private func calculateBasicCost(weight: Double, length: Double, width: Double, height: Double) -> Double {
        let volume = length * width * height
        var totalCost = 3.00 // Base cost

        // Weight charge
        totalCost += weight * 0.50

        // Volume charge
        totalCost += (volume / 1000) * 0.10

        // Ensure minimum charge
        return max(totalCost, 4.00)
    }

    private func calculateAdvancedCost(weight: Double, length: Double, width: Double, height: Double) -> Double {
        // 1. Calculate Volume and Weight
        let volume = length * width * height
        let dimensionalWeight = volume / 5000
        let chargeableWeight = max(weight, dimensionalWeight)

        // 2. Base Cost
        var totalCost = 2.50 // Start with £2.50
        totalCost += chargeableWeight * 1.50 // £1.50 per kg
        totalCost += (volume / 1000) * 0.75 // £0.75 per litre

        // 3. Weight-based Surcharges
        if weight > 20 {
            totalCost *= 1.50
        } else if weight > 10 {
            totalCost *= 1.25
        }



        // 4. Minimum Charge
        return max(totalCost, 5.00)
    }
}

#Preview {
    ContentView()
}
