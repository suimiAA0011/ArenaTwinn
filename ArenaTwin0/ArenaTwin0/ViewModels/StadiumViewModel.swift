//
//  StadiumViewModel.swift
//  ArenaTwin0
//
//  Created by salma on 08/04/2025.
//

// ViewModels/StadiumViewModel.swift
// ViewModels/StadiumViewModel.swift
import Foundation
import Combine
// ViewModels/StadiumViewModel.swift


class StadiumViewModel: ObservableObject {
    @Published var stadiums: [Stadium] = []
    @Published var selectedStadium: Stadium?
    
    init() {
        fetchStadiums()
    }
    
    func fetchStadiums() {
        stadiums = Stadium.sampleData()
        selectedStadium = stadiums.first
    }
}
