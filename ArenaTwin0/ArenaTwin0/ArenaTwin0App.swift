//
//  ArenaTwin0App.swift
//  ArenaTwin0
//
//  Created by salma on 08/04/2025.
//

// arenaTwinApp.swift
import SwiftUI

@main
struct arenaTwinApp: App {
    @StateObject private var fanViewModel = FanViewModel()
    @StateObject private var stadiumViewModel = StadiumViewModel()
    @StateObject private var adminViewModel = AdminViewModel()
    
    var body: some Scene {
       
                WindowGroup {
                    SplashView()
                        .environmentObject(adminViewModel)
                }
            }
        }
    
