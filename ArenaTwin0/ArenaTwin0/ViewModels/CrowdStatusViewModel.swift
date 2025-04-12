//
//  CrowdStatusViewModel.swift
//  ArenaTwin0
//
//  Created by salma on 12/04/2025.
//

// ViewModels/CrowdStatusViewModel.swift
import Foundation

class CrowdStatusViewModel: ObservableObject {
    @Published var crowdStatuses: [CrowdStatusModel] = [
        CrowdStatusModel(area: "البوابة الرئيسية", status: "مزدحم", capacity: 1000, currentCount: 900),
        CrowdStatusModel(area: "المدرج الشمالي", status: "متوسط", capacity: 5000, currentCount: 3000),
        CrowdStatusModel(area: "المدرج الجنوبي", status: "هادئ", capacity: 5000, currentCount: 1000)
    ]
}
