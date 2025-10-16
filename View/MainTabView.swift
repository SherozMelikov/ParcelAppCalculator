//
//  MainTabView.swift
//  ParcelAppCalculator
//
//  Created by Sheroz Melikov on 14/10/2025.
//
import SwiftUI
struct MainTabView:View {
    var body: some View {
        TabView{
            ContentView()
                .tabItem{
                Label("Calculator",systemImage: "function")
            }
            HistoryView()
                .tabItem{
                    Label("History",systemImage: "clock")
                }
            
        }
    }
}
#Preview {
    MainTabView()
}

