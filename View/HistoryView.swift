//
//  HistoryView.swift
//  ParcelAppCalculator
//
//  Created by Sheroz Melikov on 14/10/2025.
//

import SwiftUI
import SwiftData
struct HistoryView: View {
    @Query var parcels: [ParcelDataModel]
    
    var body: some View {
        NavigationStack {
            VStack {
                // Debugging
                Text("Number of parcels: \(parcels.count)")  // This will show the number of records
                List(parcels) { parcel in
                    Text(parcel.postDate, format: Date.FormatStyle().day().month().year())
                    Text(parcel.weight)
                    Text(parcel.volume)
                    Text(parcel.cost)
                }
            }
            .padding(.vertical, 5)
            .navigationTitle("Calculation History")
            .onAppear {
                // Debugging parcels on appear
                print("Fetched parcels: \(parcels)")
            }
        }
    }
}
#Preview {
    HistoryView()
}
