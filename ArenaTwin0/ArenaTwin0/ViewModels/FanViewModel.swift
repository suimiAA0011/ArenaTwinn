//
//  FanViewModel.swift
//  ArenaTwin0
//
//  Created by salma on 08/04/2025.
//

// ViewModels/FanViewModel.swift
import Foundation
import Combine

class FanViewModel: ObservableObject {
    @Published var fan: Fan = Fan(id: "123", name: "Salma", favoriteTeam: "Al Hilal", ticketIDs: [], isInsideStadium: false)

    func checkInToStadium() {
        fan.isInsideStadium = true
    }

    func checkOutFromStadium() {
        fan.isInsideStadium = false
    }
}
