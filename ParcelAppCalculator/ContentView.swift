import SwiftUI

struct ContentView: View {
    @State private var weight: String = ""
    @State private var length: String = ""
    @State private var width: String = ""
    @State private var height: String = ""
    @State private var depth: String = ""
    @State private var cost: String = ""
    
    var isdisabled: Bool {
        weight.isEmpty || length.isEmpty || width.isEmpty || height.isEmpty || depth.isEmpty
    }
    
    private func calculateCost() {
        print("Parcel Data: ")
        print("Height : \(height)")
        print("Width : \(width)")
        print("Length : \(length)")
        print("Weight : \(weight)")
        
        if let weightValue = Double(weight),
           let depthValue = Double(depth),
           let widthValue = Double(width),
           let heightValue = Double(height),
           weightValue > 0, depthValue > 0, widthValue > 0, heightValue > 0 {
            
            let volume = depthValue * widthValue * heightValue
            var totalCost = 3.00
            totalCost += weightValue * 0.50
            totalCost += (volume / 1000) * 0.10
            totalCost = max(totalCost, 4.00) // Ensure cost is at least £4.00
            cost = String(format: "%.2f", totalCost)
            print("£" + cost)
        } else {
            cost = "Error: Please enter a valid numeric amount"
        }
    }
    
    var body: some View {
        VStack {
            Text("Parcel Calculator")
                .font(.title)
                .padding()
            
            HStack(alignment: .center, spacing: 10) {
                Label("Weight (kg): ", systemImage: "")
                    .labelStyle(.titleOnly)
                    .frame(width: 120, alignment: .trailing)
                TextField("Enter weight: ", text: $weight)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.black, width: 2)
                    .keyboardType(.decimalPad)
            }
            
            HStack(alignment: .center, spacing: 10) {
                Label("Height (cm): ", systemImage: "")
                    .labelStyle(.titleOnly)
                    .frame(width: 120, alignment: .trailing)
                TextField("Enter height: ", text: $height)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.black, width: 2)
                    .keyboardType(.decimalPad)
            }
            
            HStack(alignment: .center, spacing: 10) {
                Label("Width (cm): ", systemImage: "")
                    .labelStyle(.titleOnly)
                    .frame(width: 120, alignment: .trailing)
                TextField("Enter width: ", text: $width)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.black, width: 2)
                    .keyboardType(.decimalPad)
            }
            
            HStack(alignment: .center, spacing: 10) {
                Label("Length (cm): ", systemImage: "")
                    .labelStyle(.titleOnly)
                    .frame(width: 120, alignment: .trailing)
                TextField("Enter length: ", text: $length)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.black, width: 2)
                    .keyboardType(.decimalPad)
            }
            
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
}

#Preview {
    ContentView()
}
